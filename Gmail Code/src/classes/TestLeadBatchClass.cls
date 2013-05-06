@istest

class TestLeadBatchClass {
   
   static testmethod void test() {
   Test.startTest();
    list<Lead> lstcon= new List<Lead>();
     list<Lead> lstcon2= new List<Lead>();
   list<string> lstid= new List<string>();

Lead oLead1 = new Lead(); 
oLead1.LastName='testUSer1';         
oLead1.mobilephone='919866007303';
olead1.company='appshark';
lstCon.add(oLead1);  

Lead oLead2 = new Lead(); 
oLead2.LastName='testUSer2';         
oLead2.mobilephone='919866005606';
olead2.company='appshark';
lstCon.add(oLead2);           

insert lstCon; 
Lead oLead3 = new Lead(); 
oLead3.LastName='testUSer1';         
//oLead3.mobilephone='919866007303';
olead3.company='appshark';
lstCon2.add(oLead3);  

Lead oLead4 = new Lead(); 
oLead4.LastName='testUSer2';         
//oLead4.mobilephone='919866005606';
olead4.company='appshark';
lstCon2.add(oLead4);           

insert lstCon2; 


   
   lstid.add(lstcon[0].id);
   lstid.add(lstcon[1].id);
   
   
   string strComments='Hai Salesforce';
   
   sendLeadbatchsms obj=new sendLeadBatchSMS(lstcon,lstcon2,strComments);
   list<string> lstallmobilephones= new list<string>();
   lstallmobilephones.add('919866007303');
   lstallmobilephones.add('919866005606');
   String strRes='ERROR\nOK';
   obj.smstaskcreation(strRes,lstallmobilephones);
   
   ID batchprocessid = Database.executeBatch(new sendLeadBatchSMS(lstcon,lstcon2,strComments),2);
   
   System.debug('**********************'+strres);

   
     
   
 
   Test.stopTest();
   }
   
}