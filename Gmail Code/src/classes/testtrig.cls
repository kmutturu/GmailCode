@isTest
private class testtrig{
    static testmethod void tre(){
        account obj = new account();
        obj.name = 'test';
        obj.Sales_Organization_Des__c = 'TEC Dom. Sales Org';
        obj.Distribution_Channel_Des__c = 'TSC-Direct to Cust';
        insert obj;
    }
}