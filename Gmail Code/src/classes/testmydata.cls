@isTest
private class testmydata{
    static testmethod void mymethod(){
        
      company__c objcomp = new company__c();
      objcomp.name = 'test';
      insert objcomp;
      
      Employee__c objemp = new Employee__c();
      objemp.company__c = objcomp.id;
      insert objemp;
     
      company__c objcomp1 = new company__c();
      objcomp1.name = 'test';
      objcomp1.Number_of_Employees__c = 9;
      insert objcomp1;
      
      Employee__c objemp1 = new Employee__c();
      objemp1.company__c = objcomp1.id;
      insert objemp1;
     
      
         
    }
}