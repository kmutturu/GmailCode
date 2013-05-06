@istest
private class testcamp{

    static testmethod void mytest(){
    
    
        lead obj = new lead();
        obj.lastname = 'test';
        obj.company = 'test';
        insert obj;
       ApexPages.currentPage().getParameters().put('id', obj.id);
        ApexPages.StandardController ApptController = new ApexPages.standardController(obj);
           leadclass obj1 = new leadclass(ApptController);
          obj1.setblren(false);
          obj1.getCampigns();
        System.assertNotEquals(true,obj1.getblren());
         leadclass  AppViewObj = new leadclass (ApptController);
       
    
    }

}