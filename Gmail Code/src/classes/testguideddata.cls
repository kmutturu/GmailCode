@istest
private class testguideddata{

    static testmethod void tetsguideddata(){
        GE_PW_User_Sales_Hierarchy_Association__c obj = new GE_PW_User_Sales_Hierarchy_Association__c();
        obj.name = 'test';
        insert obj;
        
        System.currentPageReference().getParameters().put('userid',userinfo.getuserid());
        ApexPages.StandardController ApptController = new ApexPages.standardController(obj);
        guideddata obj1 = new guideddata(ApptController);
        obj1.doDisable();
        obj1.back();
        obj1.save();
    }
}