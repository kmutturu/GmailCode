/*Class Name : SendBulkSms
* Author : Charan & Jaya Lakshmi
* Date : 05th Feb 2011
* Purpose: A global class to send sms to selected Contacts in bulk, and task is assigned based up on success status from gateway Response.
* Modification History :
*/


global class SendContactBulkSms {

    //start of Global Declaration of Variables, Lists.
    Integer  iFlength;                        //no.of Contacts for which message is sent
    Integer iSlength;                         //no.of Contacts for which message is not sent
    boolean blnRenderSelected = False;
    boolean blnRenderResult = false;
    Task objTask;                            //for creating Tasks
    list<Contact> lstCon= new list<Contact>(); //list of contactids that we selected.
    list<Contact> lstConnomobile= new list<Contact>(); //list of contacts for which no mobile number is there.                       // list for selected Contacts
    list<string> lstContactId;
    list<Contact> lstContactId1=new list<Contact>();//list of Contact id for which mobile number is there.
    list<Contact> lstContactId2=new list<Contact>(); // list of Contact ID's for which no mobile number is there.
    list<string> lstStr;                          // list of names of selected conrtacts.
    list<string> lstSCid=new list<string>();      //list Contact ids for which message is sent.
    list<string> lstSuccess=new list<string>();   //list mobilenumbers for which message is sent success fully
    list<string> lstFail=new list<string>();      //list m numbers for which message is not sent
    list<string> lstRes=new list<string>();        //list Response for each Contact.
    list<string> lstres1=new list<string>();      //list of response strings from gateway.
    list<task>  lstSTask=new list<task>();      //list of created  tasks for success.
    list<string> lstFCid=new list<string>();      //list Contact ids for which message is sent is failed.
    public list<wrapcls> lstFailure = new list<wrapcls>(); //list failure Contacts.
    public string strComments;
    list<string> lstmobilephone;        //list of mobile numbers of Selected Contacts.
    list<string>lstphone=new list<string>();
    boolean smsint=false;
    boolean smsint1=false;
    //End of Global Declaration.

    
    
    public SendContactBulkSms(){
        // for Getting selected Contacts id's
        string strIdlist=Apexpages.currentpage().getparameters().get('id');
        lstContactId=new list<string>();
        if(strIdList.indexOf(',') > 1){
            lstContactId = strIdList.split(',');
        }//end of if
        else{
            lstContactId.add(strIdList);
        }
        lstConnomobile=[select name,mobilephone from Contact where id in :lstContactId and mobilephone != null  order by mobilephone];
        if(lstconnomobile.size()== 0){
            ApexPages.Message myMsg = new ApexPages.Message(ApexPages.Severity.ERROR, 'All the  Selected Contacts do not have any Mobile Number');
            ApexPages.addMessage(myMsg);
            smsint=false;
        }
        else
            smsint=true;
        if(smsint==true){
            list<SMS_Gateway__c > lstGatewaycon = new list<SMS_Gateway__c>();
            lstGatewaycon =[select id from SMS_Gateway__c];
            if(lstGatewaycon.size()==0){
               ApexPages.Message myMsg = new ApexPages.Message(ApexPages.Severity.ERROR, 'There is no Gateway to send Sms');
                ApexPages.addMessage(myMsg);
                smsint1=false;
            
            }//end if
            else 
                smsint1=true;
            }//end if
    }//end of constructor
    public boolean getsms(){
        if(smsint==true && smsint1==true)
            return true;
        else 
            return false;
    }//Eof of getsms
    //Getting failure length to VF page
    public Integer getFlength() {
        iFlength=lstFail.size()+lstContactId2.size();
        return iFlength;
    }//eof getFlength

    //Getting Success length to VF page
    public Integer getSlength() {
        iSlength=lstSuccess.size();
        return iSlength;
    }//eof getSlength

    // for displaying summary report ion VF page
    public boolean getRenderResult() {
        return blnRenderResult;
    }//end of getRenderResult
   
    public boolean getRenderSelected() {
        return blnRenderSelected;
    }//end of getRenderselected
    
    //Properties for Comments on VF page
    public void setComments(string strComments){
        this.strComments=strComments;
    }//end of setComments
    
    public string getComments(){
        return strComments;
    }//end of getComments

    //set method for selected Contacts
    public void setSelected(list<Contact> con){
        //lstcon=new list<Contact>();
        system.debug('Contacts : '+con);
        this.lstcon=con;
    }//end of setSelected
    //get method for selected Contacts
    public List<Contact> getSelected() {
       
       lstcon=[select name,mobilephone from Contact where id in :lstContactId  order by mobilephone];
       lstContactid1=[select id,name,mobilephone from Contact where id in: lstContactId and Mobilephone != null];
       lstContactid2=[select id,name,mobilephone from Contact where id in: lstContactId and Mobilephone = null];
       return lstcon;
    
    }//end of getSelected
    // property for names for getting failure names to VF page
    
    public void setNames(list<string> lststr){
        lststr=new list<string>();
        this.lststr=lststr;
    }//end of setNames
    
    public list<wrapcls> getNames(){
        return lstFailure;
    }//end of getNames
    // Send Button on VF page,this method calls send sms method  by passing list of selected Contact ids and comments.
    
    public void SMSaction(){
        try{
              blnRenderSelected = false;
              SMS_gateway__c objsms=new SMS_gateway__c();
              list<SMS_gateway__c> lstgatewayactive = new list <SMS_gateway__c>();
            //checking whether there is any default gateway or not.
            
            list<SMS_Gateway__c > lstgateway=new list<SMS_Gateway__c >();
            lstgateway=[select name from SMS_Gateway__c where default__c =:true];
            
            if(lstgateway.size()!=0){
                 objsms=[select name,Bulk_sms_post_url__c,sms_credentials__C,Bulk_sms_to_list__c,separator__c,default__C,limit__c from SMS_gateway__c where default__C =:true];
                
            }//end of if
            //if there is no gateway as default check for Active Gate-Way and make that as Default Gate-Way.
            if(lstgateway.size() == 0){
                lstgatewayactive=[select id from SMS_Gateway__c where active__c =: true];
                if(lstgatewayactive.size()!=0)
                    objsms=[select name,Bulk_sms_post_url__c,sms_credentials__C,Bulk_sms_to_list__c,separator__c,default__C,limit__c from SMS_gateway__c where active__c =: true order By LastModifiedDate Desc  limit 1]; 
               //if there is no Gate-Way as Active then select gateway based on lastmodifieddate and make that as default gateway.
           
                else
                    objsms=[select name,Bulk_sms_post_url__c,sms_credentials__C,Bulk_sms_to_list__c,separator__c,default__C,limit__c from SMS_gateway__c order By LastModifiedDate Desc limit 1]; 
                
            }//end if
            if(lstContactid.size()/objsms.limit__c >=10){
                integer iscope=objsms.limit__c.Intvalue();
                blnRenderSelected=true;
                id batchjobid=database.executebatch(new sendContactBatchSMS (lstContactId1,lstContactId2,strComments),iscope); 
             
            }
        else{
                
                sendSms (lstContactId1,strComments,objsms);
                
            }//end else
            insert lstStask;
            
        }//end of try
        catch(exception ex){
            ApexPages.Message myMsg = new ApexPages.Message(ApexPages.Severity.ERROR, ex.getMessage());
            ApexPages.addMessage(myMsg);
         }//end of catch
    }//end of SMSaction method

    /*
    * METHOD DEFINITION: - sendSmsMethod(list of stringof idList,string comments,sms_gateway object)
    * This method take the list of Contact ids and subject as parameters and call the sendbulk method
    * INPUT: - string idList,string comments,SMS_gateway__c objsms
    * OUTPUT: - calls send bulk method
    */

    public void sendSms (list<Contact> lstId1,string strComments,SMS_gateway__c objsms){
     
        set<string> setph=new set<string>();
        
        try{
           
            for(Contact c : [select id,mobilephone,lastname,sms_opt_out__c from Contact where id in :lstId1 and sms_opt_out__c=:false]){
              
                setph.add(c.mobilephone);
                
            }//end of for
            
            //check if any contacts in the selected list having mobile number 
            if(setph.size() > 0){
             sendBulk(setPh,strComments,objsms);//called method with list of mobilephone numbers and list of Contactids and comments as arguments.
             smsTaskcreation(lstres1,lstphone);
            }
        }//end of try of sendsms
        catch(exception ex){
            ApexPages.Message myMsg = new ApexPages.Message(ApexPages.Severity.ERROR, ex.getMessage());
            ApexPages.addMessage(myMsg);
        }//eof catch of sendsms
    }//eof sendSms  method

    /*
    * METHOD DEFINITION: - sendBulk(set<String> mobilemobilephone,string comments,SMS_gateway__c objsms)
    * This method take the list of mobilemobilemobilephone numbers,comments and sms_gateway object reference as parameter
    * INPUT: - set of mobilephone numbers,subject,sms gateway object reference
    * OUTPUT: - calls check method for dividing list of phone numbers to send sms based on callouts limits and gateway limit.
    */

     public void sendBulk(set<String> setph,string strComments,SMS_gateway__c objsms){
         try{
         
         string strMes =EncodingUtil.urlEncode(strComments,'UTF-8');
         lstphone.addAll(setph);
         lstphone.sort();
         check(setph,strMes,objsms);
           
         }//End of try
         
         catch(exception ex){
            ApexPages.Message myMsg = new ApexPages.Message(ApexPages.Severity.ERROR, ex.getMessage());
            ApexPages.addMessage(myMsg);
         }//end of catch
    }//end of send bulk method

    /*
    * METHOD DEFINITION: - check(set<string> setph,string strMes,SMS_gateway__c objsms)
    * This method take the list of mobilemobilemobilephone , subject,sms_gateway objectreference as parameter
    * INPUT: - set of mobilephone numbers,subject,sms gateway object reference
    * OUTPUT: - it calls the callout method to send bulk sms.
    */

    public void check(set<string> setph,string strMes,SMS_gateway__c objsms){
        try{
            lstmobilephone=new list<string>();
             lstmobilephone.addAll(setph);
            lstmobilephone.sort();
           
            String strSl='';
            decimal climit=objsms.limit__c;
            string strMsgdetails=objsms.Bulk_sms_to_list__c;
            if(lstmobilephone.size()>climit){
                list<string>lsttemp=new list<string>();
                for (integer i=0;i<climit;i++){  
                    lsttemp.add(lstmobilephone[i]);
                }//end for
               
                for(integer i=0;i<lsttemp.size();i++){
                    strSl=strSl+objsms.separator__c+lstmobilephone[i];
                }//end of for
                                 
                strSl=strSl.substring(1,strSl.length());
                strMsgdetails= strMsgdetails.replace('$to$',strSl);
                strMsgdetails= strMsgdetails.replace('$text$',strMes);
                string strURL=objsms.Bulk_sms_post_url__c+'?'+objsms.sms_credentials__C+strMsgdetails;
                callout(strURL,lsttemp);
                setph.removeall(lsttemp);
                lsttemp.clear();
                check(setph,strMes,objsms);
                
            }//end if
            else{
                for(integer i=0;i<lstmobilephone.size();i++){
                    strSl=strSl+''+objsms.separator__c+''+lstmobilephone[i];
                }//end of for loop
                strSl=strSl.substring(1,strSl.length());
                strMsgdetails= strMsgdetails.replace('$to$',strSl);
                strMsgdetails= strMsgdetails.replace('$text$',strMes);
                string strURL=objsms.Bulk_sms_post_url__c+'?'+objsms.sms_credentials__C+strMsgdetails;
                callout(strURL,lstmobilephone);              
            }//end else
        }// end of try    
        catch(exception ex){
                ApexPages.Message myMsg = new ApexPages.Message(ApexPages.Severity.ERROR, ex.getMessage());
                ApexPages.addMessage(myMsg);
        }//end of catch
            
    }//end of check method.
    
    /*
    * METHOD DEFINITION: - callout(string strUrl,list<string>mobileophones)
    * This method take the endpointurl and list of mobilephonenumbers as parameter
    * INPUT: - set of mobilephone numbers,subject,sms gateway object reference
    * OUTPUT: - it send the sms by making Http Request.
    */

    public void  callout(string strURL,list<string>lstmobilephone){
    
        try{
        
            HttpRequest req = new HttpRequest();// http request object creation
            req.setEndpoint(strUrl);
            req.setMethod('POST');
            string strBody='hai';    
            req.setBody ( strBody);
            req.setCompressed(true);
            Http http = new Http();//http object creation
            HTTPResponse res = http.send(req);//sending the request by using HTTPResponse object
            string strRes=res.getbody();
            lstres1.add(strRes);
            blnRenderResult = true;
            
        }//end of try
        
        catch(exception ex){
            lstContactId2.clear();
            ApexPages.Message myMsg = new ApexPages.Message(ApexPages.Severity.ERROR, 'Please Register this Gateway in Remote site settings');
            ApexPages.addMessage(myMsg);
        }//end of catch
    }//end of callout method

    //Wrapper class to highlight the Contacts
    public class wrapcls{
        public Contact con{get;set;}
        public String strStyle{get;set;}    
        public wrapcls(Contact con, String strStyle){
            this.con = con;
            this.strStyle = strStyle;
        }//end of wrap class constructer
    }//end wrapper class
    

    /*
    * METHOD DEFINITION: - SMSTaskCreation(String strRes,List<String> lstmobilephone)
    * This method take the  response from gateway,list of selected Contact mobilenumbers as parameters 
    * INPUT: - String strRes,List<String> lstmobilephone
    * OUTPUT:-  creting the Tasks for Success As well as Sms failure Contacts.
    */
    
   public void SMSTaskCreation(list<string> lstres2,List<String> lstmobilephone){ 
        try{
        if(lstres2.size()>0){
            string sresponse='';
            for(integer i=0;i<lstres2.size();i++){
                sResponse=sResponse+lstRes2[i];
            }   
            lstRes=new list<string>();
            lstRes=sResponse.split('\n');
                      
            for(Integer i=0;i<lstRes.size();i++){
                if(lstRes[i].contains('ERR'))
                lstFailure.add(new wrapcls(lstContactid1[i],'Orange'));
            }//end of for
            
                      
            //based on response getting from the gateway add the mobile numbers to respective lists.
                        for(Integer i=0;i<lstRes.size();i++){
            
                 if(lstRes[i].contains('ERR'))
                    lstFail.add(lstmobilephone[i]);
                    
                 else if(lstRes[i].contains('OK'))
                    lstSuccess.add(lstmobilephone[i]);
            }//end of for
          
           
            //getting success Contact ids for which message sending is success.
            if(lstSuccess.size()>0){
                lstSCid=new list<string>();
                for(Contact c:[select id from Contact where mobilephone in :lstSuccess]){
                
                lstSCid.add(c.id);
               
        
                }//end of for
                 
            //creating  tasks for Contacts for which message is sent successfully
               
                for(Integer i=0;i<lstSCid.size();i++){
                    objTask = new Task();
                    objTask.subject=strComments;
                    objTask.type='Bulk SMS';
                    objTask.whoId=lstSCid[i];
                    objTask.status='Completed';
                    objTask.SMS_Status__c='Success';
                    lstSTask.add(objTask);
                }//end of for
            
            }// eof if
            
            if(lstFail.size()>0){
                lstFCid=new list<string>();
                for(Contact c:[select id from Contact where mobilephone in :lstFail]){
                
                lstFCid.add(c.id);
               
        
                }//end of for
            //creating  tasks for Contacts for which message is Failed
               
                for(Integer i=0;i<lstFCid.size();i++){
                    objTask=new Task();
                    objTask.subject=strComments;
                    objTask.type='Bulk SMS';
                    objTask.whoId=lstFCid[i];
                    objTask.status='Completed';
                    objTask.SMS_Status__c='Failure';
                    lstSTask.add(objTask);
                }//end of for
            
            }// eof if
            }
            // Adding the contacts for which no mobile number is there to Failure List.
            if(lstContactId2.size()!=null){
            for(Contact con:lstContactId2)
            {
                lstFailure.add(new wrapcls(con,'Orange'));
                
            }
            }
            //Crating Tasks For contacts for which no mobile number is there 
            if(lstContactId2.size()>0){
                for(Integer i=0;i<lstContactId2.size();i++){
                    objTask=new Task();
                    objTask.subject=strComments;
                    objTask.type='Bulk SMS';
                    objTask.whoId=lstContactId2[i].id;
                    objTask.status='Completed';
                    objTask.SMS_Status__c='Failure';
                    lstSTask.add(objTask);
                }//end of for
            }
        }//end of try of SMSTaskCreation
         
         catch(exception ex){
            ApexPages.Message myMsg = new ApexPages.Message(ApexPages.Severity.ERROR, ex.getMessage());
            ApexPages.addMessage(myMsg);
          }//end of catch SMSTaskCreation
    }//eof SMSTaskCreation method
}//eof class