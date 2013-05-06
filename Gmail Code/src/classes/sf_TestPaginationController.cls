/*
        Name           : sf_TestPaginationController
        Author         : iBirds Software Services
        Date           : 18th July 2012
        Description    : Test class of PaginationController
*/
@isTest
public class sf_TestPaginationController{
    // test method
    public static testMethod void test(){
        // create test Account
        Account acc = new Account(Name='testAccount');
        insert acc;
        
        // create Contact List
        List<Contact> lstContact = new List<Contact>();
        
        //add 11 test contact in list
        for(Integer counter=1 ; counter<=11 ; counter++)
            lstContact.add(new Contact(FirstName='Test'+counter,LastName='LastTest'+counter,Email='test@test.com',AccountId=acc.Id));
            
        // insert contacts
        insert lstContact;
        
        sf_PaginationController pagination = new sf_PaginationController();
        pagination.next();
        pagination.previous();
        pagination.first();
        pagination.last();
        pagination.getItems();
        pagination.getRecords();
        pagination.getRecordInfo();
        pagination.pageNavigation();
        pagination.pageNumber = 4;
        pagination.pageNavigation();
        pagination.pageNumber = 0;
        pagination.pageNavigation();
        pagination.changeLimit();
        pagination.getTotalPage();
    }
}