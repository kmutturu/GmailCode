@isTest
private class testlead{
    static testmethod void testmy(){
        Lead objLead = new Lead();
        objLead.lastname = 'test';
        objLead.company = 'testcompany';
        insert objLead;
        
        
    }
}