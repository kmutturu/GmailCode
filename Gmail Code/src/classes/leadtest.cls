@isTest
private class leadtest{
    static testmethod void lkdk(){
    
        lead obj = new lead();
        obj.lastname = 'test';
        obj.company = 'test';
        obj.phone = '+1212321398';
        insert obj;
    }
}