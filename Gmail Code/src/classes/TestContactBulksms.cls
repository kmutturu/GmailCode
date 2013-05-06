/*Class Name : TestContactBulksms
 * Author : Charan & Jaya Lakshmi 
 * Date   : 04 Feb 2011
 * Purpose: To test the codecoverage of sendsms class.
 * Modification History : 
 * 
*/
 
@ istest

private class  TestContactBulksms{
    
    static public testmethod void testsendBulksmsMethod(){
    
    
    SMS_Gateway__c objsms = new SMS_Gateway__c ();
    objsms.name='smsglobal';
    objsms.Bulk_sms_post_url__c='http://www.smsglobal.com/http-api.php';
    objsms.sms_credentials__C='action=sendsms&user=sum617&password=62009305&from=Appshark';
    objsms.Bulk_sms_to_list__c='&to=$to$&text=$text$';
    objsms.separator__c=',';
    objsms.default__c=true;
    objsms.limit__c =25;
    objsms.SMS_POST_URL__c='http://www.smsglobal.com/http-api.php';
    objsms.SMS_To_List__c='&to=$to$&text=$text$';
    insert objsms;
     list<contact> lstContact =new list<contact>();
        Contact oContact1 = new Contact(); 
        oContact1.LastName='testUSer';         
        oContact1.mobilephone='919866007303';
        lstContact.add(oContact1);  
 
        Contact oContact2 = new Contact(); 
        oContact2.LastName='testUSer1';         
        oContact2.mobilephone='919866005606';
        lstContact.add(oContact2);  
         Contact oContact3 = new Contact(); 
        oContact3.LastName='testUSer1';   
    lstContact.add(ocontact3);        
              
        insert lstContact; 
         
    string sMsg='hai';
     String comments=null;  
    ApexPages.currentPage().getParameters().put('id',oContact1.id+','+ocontact2.id+','+ocontact3.id);
           
     sendcontactbulksms objSendContactBulksms = new  sendcontactbulksms();
        
       
       
             
       
         
        objSendContactBulksms.getSelected();
        objSendContactBulksms.setselected(lstcontact);
        objSendContactBulksms.getcomments();
        objSendContactBulksms.setComments('jaya');
       
        string s='ERR \n OK ';       
        
        list<string> lstres=new list<string>();
        lstres.add(s);
        
        
        set<string> setph=new set<string>();
        List<string> ph=new list<string>();
        ph.add(oContact1.mobilephone);
        ph.add(oContact2.mobilephone);
        
        setph.add(oContact1.mobilephone);
        setph.add(oContact2.mobilephone);
       
          
        objSendContactBulksms.smsaction();           
        
        
        
        list<string> lstnames=new list<string>();
        lstnames.add(ocontact1.lastname);
        //objSendContactBulksms.setsms(true);
        objSendContactBulksms.getsms();
        objSendContactBulksms.setnames(lstnames);
        objSendContactBulksms.getnames();
        
        objSendContactBulksms.getFlength();
        objSendContactBulksms.getslength();
        objSendContactBulksms.getRenderresult();
        objSendContactBulksms.getRenderselected();
        
        objSendContactBulksms.sendSms(lstContact,sMsg,objsms);
        objSendContactBulksms.check(setph,sMsg,objsms);
        objSendcontactBulksms.callout('http://www.smsglobal.com/http-api.php?action=sendsms&user=apps2&password=12345678&from=Appshark&to=919985954447,40241544485&text=HI+this+is+last+test+msg',ph);
        
        objSendContactBulksms.SMSTaskCreation(lstres,ph);
        
     }     
 
}