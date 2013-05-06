@isTest
private class testmw{

    static testmethod void hkjs(){
    
        contact objc = new contact();
        objc.lastname = 'test';
        insert objc;
        list<contact> lstcon = new list<contact>();
        lstcon.add(objc);
        ApexPages.currentPage().getParameters().put('retURL', '');
        ApexPages.StandardSetController ApptController = new ApexPages.StandardSetController(lstcon);
        massupdatefield obj = new massupdatefield(ApptController);
        obj.updatecontacts();
    }
}