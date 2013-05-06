/**
 * This class contains unit tests for validating the behavior of Apex classes
 * and triggers.
 *
 * Unit tests are class methods that verify whether a particular piece
 * of code is working properly. Unit test methods take no arguments,
 * commit no data to the database, and are flagged with the testMethod
 * keyword in the method definition.
 *
 * All test methods in an organization are executed whenever Apex code is deployed
 * to a production organization to confirm correctness, ensure code
 * coverage, and prevent regressions. All Apex classes are
 * required to have at least 75% code coverage in order to be deployed
 * to a production organization. In addition, all triggers must have some code coverage.
 * 
 * The @isTest class annotation indicates this class only contains test
 * methods. Classes defined with the @isTest annotation do not count against
 * the organization size limit for all Apex scripts.
 *
 * See the Apex Language Reference for more information about Testing and Code Coverage.
 */
@isTest
private class CustomerRequestEntryControllerTEST {

    static testMethod void createSaveTest() {
        //Create an account requests can be attached to
        Account acct = new Account(Name = 'Super Cool Account 5000');
        insert acct;
        
        //Setup page parameters for testing
        Test.setCurrentPageReference(new PageReference('Page.customerRequestQuickEntry')); 
		ApexPages.currentPage().getParameters().put('id', acct.id);
		
		Test.startTest();
		//Instantiate controller, contructor will run
		CustomerRequestEntryController controller = new CustomerRequestEntryController();
		
		//Create new request
		controller.newRequest();
		
		//Set Name on request
		controller.requests[0].Subject__c = 'request1';
		
		//Save Requests
		controller.save();
		
		Test.stopTest();
		
		//Assert that customer request record was attached to account.
		Customer_Request__c cr = [select Id, Subject__c from Customer_Request__c where Account__c = :acct.Id];
		system.assertEquals(cr.Subject__c,'request1');
    }
}