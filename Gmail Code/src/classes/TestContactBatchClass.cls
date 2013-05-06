@istest

class TestContactBatchClass {
   
   static testmethod void test() {
   Test.startTest();
    list<contact> lstcon= new List<contact>();
    list<contact> lstcon2= new List<contact>();
   list<string> lstid= new List<string>();

Contact oContact1 = new Contact(); 
oContact1.LastName='testUSer1';         
oContact1.mobilephone='919866007303';
lstCon.add(oContact1);  

Contact oContact2 = new Contact(); 
oContact2.LastName='testUSer2';         
oContact2.mobilephone='919866005606';
lstCon.add(oContact2);           

insert lstCon; 
Contact oContact3 = new Contact(); 
oContact3.LastName='testUSer1';         
//oContact3.mobilephone='919866007303';
lstCon2.add(oContact3);  

Contact oContact4 = new Contact(); 
oContact4.LastName='testUSer2';         
//oContact4.mobilephone='919866005606';
lstCon2.add(oContact4);           

insert lstCon2; 

   
   lstid.add(lstcon[0].id);
   lstid.add(lstcon[1].id);
   
   
   string strComments='Hai Salesforce';
   
   sendContactbatchsms obj=new sendContactBatchSMS(lstcon,lstcon2,strComments);
   list<string> lstallmobilephones= new list<string>();
   lstallmobilephones.add('919866007303');
   lstallmobilephones.add('919866005606');
   String strRes='ERROR\nOK';
   obj.smstaskcreation(strRes,lstallmobilephones);
   
   ID batchprocessid = Database.executeBatch(new sendContactBatchSMS(lstcon,lstcon2,strComments),2);
   
   System.debug('**********************'+strres);

   
     
   
 
   Test.stopTest();
   }
   
}