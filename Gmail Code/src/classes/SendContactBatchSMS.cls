/*Class Name : SendContactBatchSMS
* Author : Jaya Lakshmi & Charan 
* Date : 05th Feb 2011
* Purpose: A global Batch class invoked from Send ContactBulksms to send sms to selected Contacts in bulk, 
* and task is assigned based up on success status from gateway Response.
* Modification History :
*/


global class SendContactBatchSMS implements Database.Batchable<sObject>, Database.AllowsCallouts{

    /*Start fo Global Variable Declarations*/
    
    list<string> lstRes;             //List of response strings from gateway.
    list<string> lstAllMobilePhones; //List of all mobile phones
    list<string> lstSphone;          //Success list of Phone numbers    
    list<string> lstFphone;          //Failure list of phone numbers  
    list<string> lstScontactid;      //List of Success Contact Id's   
    list<string> lstFcontactid;      //List of Failure Contact Id's  
    list<task> lstStask = new list<task>();             //List for adding tasks to both Success and Failure
    list<contact> lstScon;              //For getting list of ID's from Controller
    list<Contact> lstFCon=new list<contact>(); //List for selected Contacts
    string strComments;              // Comments used in the Msg body of VF page
    
    /*End of Global Variable Declarations*/
    
    /*
    * METHOD DEFINITION: - sendBatachSMS(list of Contacts lstcon,list of ids lstid, string comments)
    * This method is a Constructor called from SendContactbulkSMS Controller inorder to process and execute the Batch Apex
    * INPUT: - list<contact> lstcon,list<string> lstid,string strComments
    */
    
    public SendContactBatchSMS(list<contact> lstcon1,list<Contact> lstcon2,string strComments){
        
        
        lstScon=lstcon1;
        lstFcon=lstcon2;
        this.strComments=strComments;
    }//end of constructor
    
    public list<contact> getListContacts(){
        return lstScon;
    }
    
    /*
    * METHOD DEFINITION: - Start Method of Batch Apex
    * INPUT: - batchableContext bc
    * OUTPUT: - Gets the List of Contacts
    */
    
    global list<contact> start(Database.BatchableContext BC) {
        for(Integer i=0;i<lstFcon.size();i++){
                Task objTask=new Task();
                objTask.subject=strComments;
                objTask.type='Bulk SMS';
                objTask.whoId=lstFcon[i].id;
                objTask.status='Completed';
                objTask.SMS_Status__c=' Failure';
                lstSTask.add(objTask);
            }//end of for loop
            if(lstSTask.size()>0)
            {
                insert lstSTask;
                lstSTask.clear();
            }
        return getListContacts();
    }//end of start method
    
    /*
    * METHOD DEFINITION: - Execute Method of Batch Apex
    * Sends the Contacts list to Execute method to process
    * INPUT: - batchableContext bc,List<contact> lstId
    * OUTPUT: - Calls Send Bulk with List of all mobilephones and comments,inorder to make a callout.
    */
    
    global void execute(Database.BatchableContext BC, List<contact> lstId){
        try{
            lstAllMobilePhones = new list<string>();
            for(Contact c : [select id,mobilephone,lastname,sms_opt_out__c from Contact where id in :lstId and sms_opt_out__c=:false]){
            lstAllmobilephones.add(c.mobilephone);       
            }//end of for
            
            sendBulk(lstAllmobilephones,strComments);//called method with list of mobilephone numbers and list of Contactids and comments as arguments.
        }//end of try
        
        catch(exception ex){
            ApexPages.Message myMsg = new ApexPages.Message(ApexPages.Severity.ERROR, ex.getMessage());
            ApexPages.addMessage(myMsg);
        }//end of catch
    }//end of execute method.

    /*
    * METHOD DEFINITION: - Finish Method of Batch Apex
    * INPUT: - batchableContext bc
    */
        
    global void finish(Database.BatchableContext BC){
    }//end of finish
    
    /*
    * METHOD DEFINITION: - Send Bulk caleld from Excute Method
    * Checks for the Gateway,replaces to wwith mobilephone from list and text with comments. URL is formed and sent to callout method 
    * INPUT: - list<String> lstAllmobilephone,string strComments
    * OUTPUT: - Calls callout method with URl and list of Mobilephones as parameters.
    */
    public void sendBulk(list<String> lstAllmobilephone,string strComments){
        try{
            string strMes =EncodingUtil.urlEncode(strComments,'UTF-8');
            SMS_gateway__c objsms=new SMS_gateway__c();
            //checking whether there is any default gateway or not.
            list<SMS_Gateway__c > lstgateway=new list<SMS_Gateway__c >();
            lstgateway=[select name from SMS_Gateway__c where default__c =:true];
            
            if(lstgateway.size()!=0){
            objsms=[select name,Bulk_sms_post_url__c,sms_credentials__C,Bulk_sms_to_list__c,separator__c,default__C ,limit__c from SMS_gateway__c where default__C =:true];
            }//end of if
            
            if(lstgateway.size() == 0){
            objsms=[select name,Bulk_sms_post_url__c,sms_credentials__C,Bulk_sms_to_list__c,separator__c,default__C,limit__c from SMS_gateway__c order By LastModifiedDate Desc limit 1]; 
            }//end of if
            
            string strName=objsms.name;
            string strUrlpath=objsms.Bulk_sms_post_url__c;
            string strCredits=objsms.sms_credentials__C;
            string strMsgdetails=objsms.Bulk_sms_to_list__c;
            string strSeparator=objsms.separator__c;
            Decimal slimit=objsms.limit__c;
            string strSl=''; 
            
            for(integer i=0;i<lstAllmobilephones.size();i++){
            strSl=strSl+''+strSeparator+''+lstAllmobilephones[i];
            }//end of for loop
            
            strSl=strSl.substring(1,strSl.length());
            strMsgdetails= strMsgdetails.replace('$to$',strSl);
            strMsgdetails= strMsgdetails.replace('$text$',strMes);
            string strURL=strUrlpath+'?'+strCredits+strMsgdetails;
            
            system.debug('################strmsgdetails##############'+strmsgDetails);
            system.debug('################strmsgdetails##############'+strURL);
            
            callout(strURL,lstAllmobilephones);  
        }//end of try
        catch(exception ex){
            ApexPages.Message myMsg = new ApexPages.Message(ApexPages.Severity.ERROR, ex.getMessage());
            ApexPages.addMessage(myMsg);
        }//end of catch
        
    }//end of send bulk method
    
    /*
    * METHOD DEFINITION: - Callout method called from sendbulk method inorder to make a callout
    * URL to post is sent and response is gathered from gateway. Based on gateway response, Type and Status are updated on task. 
    * INPUT: - String strURL,list<String> lstAllmobilephone
    * OUTPUT: - Returns response from Gateway and based on it, tasks are created.
    */
    
    public void  callout(string strURL,list<string> lstAllmobilephones){
        try{    
            // http request object creation
            HttpRequest req = new HttpRequest();
            
            // Setting Endpoint
            req.setEndpoint(strUrl);
            req.setMethod('POST');
            string strBody='hai';    
            req.setBody ( strBody);
            req.setCompressed(true);
            
            //http object creation
            Http http = new Http();
            
            //sending the request by using HTTPResponse object
            HTTPResponse res = http.send(req);
            string strRes=res.getbody();
            smsTaskcreation(strRes,lstAllmobilephones);
        }//end of try
        catch(exception ex){
            ApexPages.Message myMsg = new ApexPages.Message(ApexPages.Severity.ERROR, ex.getMessage());
            ApexPages.addMessage(myMsg);
        }//end of catch
    } //end of callout method 
    
     /*
    * METHOD DEFINITION: - smsTaskcreationmethod called from sendbulk method inorder to make create a task
    * URL to post is sent and response is gathered from gateway. Based on gateway response, Type and Status are updated on task. 
    * INPUT: - string strRes,list<string>lstAllmobilephones
    * OUTPUT: - Returns response from Gateway and based on it, tasks are created.
    */
       
    public void smsTaskcreation(string strRes,list<string>lstAllmobilephones){
        try{
        
            lstRes = new list<string>();
            lstRes=strRes.split('\n');
            
            lstSphone=new list<string> ();
            lstFphone=new list<string> ();
            
            system.debug('responseeeeeeeeeee'+lstRes);
            for(integer i=0;i<lstRes.size();i++)
            {   
                if(lstres[i].contains('ERR'))
                    lstFphone.add(lstAllmobilephones[i]);
                else if(lstres[i].contains('OK'))
                    lstSphone.add(lstAllmobilephones[i]);
                
                }
                lstScontactid=new list<string> ();
                lstFcontactid=new list<string> ();
                if(lstSphone.size()!=null){
                for(Contact c:[select id from Contact where mobilephone in :lstSphone]){
                
                lstScontactid.add(c.id);
                } //end for
            }//end if sucessids
            if(lstFphone.size()!=null){  
            for(Contact c:[select id from Contact where mobilephone in :lstFphone]){
            
                lstFcontactid.add(c.id);
            } //end for 
            }//end if failids  
            lstStask=new list<task> ();
            // For success ids
            for(Integer i=0;i<lstScontactid.size();i++){
                Task objTask=new Task();
                objTask.subject=strComments;
                objTask.type='Bulk SMS';
                objTask.whoId=lstScontactid[i];
                objTask.status='Completed';
                objTask.SMS_Status__c='Success';
                lstSTask.add(objTask);
            }//end of for
            //insert lstSTask;    
            
            //for failure ids
            for(Integer i=0;i<lstFcontactid.size();i++){
                Task objTask=new Task();
                objTask.subject=strComments;
                objTask.type='Bulk SMS';
                objTask.whoId=lstFcontactid[i];
                objTask.status='Completed';
                objTask.SMS_Status__c=' Failure';
                lstSTask.add(objTask);
            }//end of for loop
            /*for(Integer i=0;i<lstFcon.size();i++){
                Task objTask=new Task();
                objTask.subject=strComments;
                objTask.type='Bulk SMS';
                objTask.whoId=lstFcon[i].id;
                objTask.status='Completed';
                objTask.SMS_Status__c=' Failure';
                lstSTask.add(objTask);
            }//end of for loop*/
            insert lstSTask;
            system.debug('444444444response'+lstRes);
        
        }//end of try
        catch(exception ex){
            ApexPages.Message myMsg = new ApexPages.Message(ApexPages.Severity.ERROR, ex.getMessage());
            ApexPages.addMessage(myMsg);
        }//end of catch
    }//end of Task creation method
    
}//end of class.