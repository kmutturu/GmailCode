@isTest
private class testsub{
    static testmethod void testmy(){
    
        Fiber_Qualified_Address__c  obj1 = new Fiber_Qualified_Address__c();
        obj1.street_address__c ='testadd';
        obj1.loc__c = 'testloc';
        obj1.zip_code__c = '8748355';
        insert obj1;
        
        Subscriber__c obj = new Subscriber__c();
        obj.street_address__c ='testadd';
        obj.loc__c = 'testloc';
        obj.zip_code__c = '8748355';
        insert obj;
    }
}