/*Class Name : testSmsCalloutTrigger                   
 * Author : Charan & Jaya Lakshmi 
 * Date   : 02nd Feb 2011
 * Purpose: To test the codecoverage of sendsms class.
 * Modification History : 
 * 
*/
 


@ istest

private class  TestsmsTaskTrigger{

static public testmethod void testsendsmstrigMethod()
{
  Profile obj=[select id from Profile limit 1];  
User standard = new User(alias = 'standt',
email='standarduser@testorg1.com',
emailencodingkey='UTF-8',
lastname='Testing11', languagelocalekey='en_US',
localesidkey='en_US',
profileid =obj.id,
timezonesidkey='America/Los_Angeles',mobilephone='917842372919',
username='standarduser@testorg1.com');
      insert standard;
      
       Task tobj=new Task();
       tobj.ownerId = standard.Id;
       tobj.subject='testing Sms callout';
       tobj.send_sms__c=true;
       insert tobj;
} 

}