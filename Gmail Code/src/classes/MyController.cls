public class MyController {
    public PageReference invokeService() {
        Id id = System.currentPageReference().getParameters().get('cid');
        //result = [SELECT Name FROM Person__c WHERE Id=:id].Name;
        Unit_code__c result = [SELECT id,name FROM Unit_code__c WHERE Id=:id];
        return null;
    }
    public List<Unit_code__c> getPeople() {
        return [SELECT Id,name,status__c FROM Unit_code__c
            ORDER BY LastModifiedDate DESC LIMIT 10];
    }
}