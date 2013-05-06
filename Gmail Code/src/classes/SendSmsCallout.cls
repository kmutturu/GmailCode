/*Class Name : SendSmsCallout                   
 * Author : Charan & Jaya Lakshmi 
 * Date   : 02nd Feb 2011
 * Purpose: To send sms to  user whenever a task is assigned.
 * Modification History : 
 * Reviewed by  :   Shravan on 22/02/2011
 * 
*/
 
global class SendSmsCallout {

/* 
@future annotation is used for handling HTTP callouts and Callout should be true 
and method declared as future should be static and void return type
*/

@future(callout=true)

/*
     * METHOD DEFINITION: - sendSmsMethod(subject,description, phone)
     * This method has the task subject and Assigned  user  mobilephone number as parameters.
     * INPUT: -  Task.subject,task. description,user.Phone
     * OUTPUT: - 
*/
 webservice static void sendSmsMethod (string strSubject,string strDescription, string strPhone){

    try{
        
        //strDescription='';
        //HTTP Request Invoking
        HttpRequest req = new HttpRequest();
        //combining the subject and comments and trucate string into 160 chars length.
        //Encoding subject to UTF-8 format.
        string  strMes;
        if(strDescription!=null)
          strMes=strSubject+':'+strDescription;
        else
         strMes=strSubject;
        if(strMes.length()>160)
        strMes=strMes.substring(0,159);
        strMes =EncodingUtil.urlEncode(strMes,'UTF-8'); 
        
        //  getting gate-way details from object and Passing Credentials through Variables
        SMS_Gateway__c objsms=new SMS_Gateway__c ();
        list<SMS_Gateway__c > lstgateway=new list<SMS_Gateway__c >();
            lstgateway=[select name from SMS_Gateway__c where default__c =:true];
            
            if(lstgateway.size()!=0){
                objsms=[select name,sms_post_url__C,sms_credentials__C,sms_To_List__c,active__C,default__C from SMS_Gateway__c where default__C=:true];
                //if there is no gateway as default select gateway based on lastmodifieddate and make that as default gateway.
            }
            
            if(lstgateway.size() == 0){
                objsms=[select name,sms_post_url__C,sms_credentials__C,sms_To_List__c,active__C,default__C from SMS_Gateway__c order By LastModifiedDate Desc limit 1];
                //objsms.default__c=true;
                //update objsms;
            }
       
        
        
        
        //ggg objsms=[select name,sms_post_url__C,sms_credentials__C,sms_To_List__c,active__C,default__C from SMS_Gateway__c where default__C=:true];
        string strMsglist=objsms.SMS_To_List__C;
         
        //replacing variables in object     
        strMsglist=strMsglist.replace('$to$',strPhone);
        strMsglist=strMsglist.replace('$text$',strMes);             
        
        string strUrl=null;
        //building the url
        strUrl=objsms.sms_post_url__C+'?'+objsms.sms_credentials__C+strMsglist;
               
        //Setting Endpoint URL to HTTP request
        req.setEndpoint(strUrl);
        
        //set the request type
        req.setMethod('POST');
        string strBody='hai';
        req.setBody (strBody);//set the body
        req.setCompressed(true);
        
        
        //HTTP object creation
        Http http = new Http();
        
        //Sending the Req throgh HTTPResponse object.
        HTTPResponse res = http.send(req);
        System.debug(res.getBody());
        System.debug(res.getStatus());
        
        
    }//eof try
    
    catch(exception ex){
    System.debug(ex);
       
    }//eof catch
  }//eof method
  
}//eof class