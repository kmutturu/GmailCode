/*Class Name : TestLeadBulksms
 * Author : Charan & Jaya Lakshmi 
 * Date   : 04 Feb 2011
 * Purpose: To test the codecoverage of sendsms class.
 * Modification History : 
 * 
*/
 
@ istest

private class  TestLeadBulksms{
    
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
     list<Lead> lstLead =new list<Lead>();
        Lead oLead1 = new Lead(); 
        oLead1.LastName='testUSer';         
        oLead1.mobilephone='919866007303';
        oLead1.company='Appshark';
        lstLead.add(oLead1);  
 
        Lead oLead2 = new Lead(); 
        oLead2.LastName='testUSer1';         
        oLead2.mobilephone='919866005606';
        oLead2.company='Appshark';
        lstLead.add(oLead2);  
         Lead oLead3 = new Lead(); 
        oLead3.LastName='testUSer1'; 
        oLead3.company='Appshark';  
    lstLead.add(oLead3);        
              
        insert lstLead; 
         
    string sMsg='hai';
     String comments=null;  
    ApexPages.currentPage().getParameters().put('id',oLead1.id+','+oLead2.id+','+oLead3.id);
           
     sendLeadbulksms objSendLeadBulksms = new  sendLeadbulksms();
        
       
       
             
       
         
        objSendLeadBulksms.getSelected();
        objSendLeadBulksms.setselected(lstLead);
        objSendLeadBulksms.getcomments();
        objSendLeadBulksms.setComments('jaya');
       
        string s='ERR \n OK ';       
        
        list<string> lstres=new list<string>();
        lstres.add(s);
        
        
        set<string> setph=new set<string>();
        List<string> ph=new list<string>();
        ph.add(oLead1.mobilephone);
        ph.add(oLead2.mobilephone);
        
        setph.add(oLead1.mobilephone);
        setph.add(oLead2.mobilephone);
       
          
        objSendLeadBulksms.smsaction();           
        
        
        
        list<string> lstnames=new list<string>();
        lstnames.add(oLead1.lastname);
        //objSendLeadBulksms.setsms(true);
        objSendLeadBulksms.getsms();
        objSendLeadBulksms.setnames(lstnames);
        objSendLeadBulksms.getnames();
        
        objSendLeadBulksms.getFlength();
        objSendLeadBulksms.getslength();
        objSendLeadBulksms.getRenderresult();
        objSendLeadBulksms.getRenderselected();
        
        objSendLeadBulksms.sendSms(lstLead,sMsg,objsms);
        objSendLeadBulksms.check(setph,sMsg,objsms);
        objSendLeadBulksms.callout('http://www.smsglobal.com/http-api.php?action=sendsms&user=apps2&password=12345678&from=Appshark&to=919985954447,40241544485&text=HI+this+is+last+test+msg',ph);
        
        objSendLeadBulksms.SMSTaskCreation(lstres,ph);
        
     }     
 
}