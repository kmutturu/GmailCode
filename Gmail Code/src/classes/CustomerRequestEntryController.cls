public with sharing class CustomerRequestEntryController{

    public Account acct {get; set;}
    public List<Customer_Request__c> requests {get; set;}

    //Constructor
    public CustomerRequestEntryController(){
        acct = [select Id, Name from Account where Id = :ApexPages.currentPage().getParameters().get('id')];
        requests = new List<Customer_Request__c>();
    }
    
    public void newRequest() {
        requests.add(new Customer_Request__c(Account__c = acct.Id));
    }
    
    public PageReference save(){
        insert requests;        
        PageReference p = new PageReference('/'+acct.Id);
        p.setRedirect(true);
        return p;
    }
}