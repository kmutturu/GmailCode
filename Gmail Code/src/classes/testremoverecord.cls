@istest
private class testremoverecord{
    static testmethod void testb(){
    
        GE_PW_User_Sales_Hierarchy_Association__c obj1 = new GE_PW_User_Sales_Hierarchy_Association__c();
        obj1.name = 'test';
        insert obj1;
        
        System.currentPageReference().getParameters().put('loc',obj1.id);
        removerecord obj = new removerecord();
        
        obj.RemoveLocationIDs();
    }
    
    
}