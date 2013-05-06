//
// Custom controller for layered lookup example main page
//
public with sharing class LayeredLookupController 
{
    public String accountName {get; set;}
    public Id accountId {get; set;}
    public List<Contact> contacts {get;set;}
    
    public String query {get; set;}
    public List<Account> accounts {get; set;}
    
    public PageReference findContacts()
    {
        if (null!=accountId)
        {
           contacts=[select id,FirstName, LastName from Contact where AccountId=:accountId];
        }
        
        return null;
    }
    
    public PageReference runQuery()
    {
        List<List<Account>> searchResults=[FIND :query IN ALL FIELDS RETURNING Account (id, name, billingstreet, billingcity, billingpostalcode)];
        accounts=searchResults[0];
        return null;
    }
}