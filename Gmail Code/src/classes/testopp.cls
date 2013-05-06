@isTest
private class testopp{
    static testmethod void temoop(){

        Opportunity opp = new Opportunity();
        opp.name = 'test';
        opp.closedate = system.today();
        opp.StageName = 'Prospecting';
        insert opp;
                

        Scope_of_Work__c obj = new Scope_of_Work__c();
        obj.Opportunity__c = opp.id;
        insert obj;
    }
}