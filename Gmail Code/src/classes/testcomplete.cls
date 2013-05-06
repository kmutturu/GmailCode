public with sharing class testcomplete {

    public testcomplete(ApexPages.StandardController controller) {

    }
    
    
    public list<account> lstAccount{get;set;}
    
    public pagereference saveme(){
    
    pagereference pf = new pagereference('test');
    
            lstAccount = [select id,name from account limit 5];
    
    return null;

    
    }

}