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
private class WidgetManagerControllerTEST {

    static testMethod void allTests() {
        //Create an account requests can be attached to
        Account acct = new Account(Name = 'Super Cool Account 5000');
        insert acct;
        
        //Setup page parameters for testing
        Test.setCurrentPageReference(new PageReference('Page.widgetManager')); 
		ApexPages.currentPage().getParameters().put('id', acct.id);
		
		//Setup the widgets
		//Attach a widget to the account
		Widget__c w1 = new Widget__c(Account__c = acct.Id, Status__c = 'Deployed');
		insert w1;
		
		//Create widget not attached to account
		Widget__c w2 = new Widget__c(Status__c = 'Inventory');
		insert w2;
				
		Test.startTest();
		//Instantiate controller, contructor will run
		WidgetManagerController controller = new WidgetManagerController();
	
		//Widget Get Methods
		controller.getInstalledWidgets();
		controller.getInventoryWidgets();
		
		//Move deployed widget to inventory
		//Set page params, updated widget
		ApexPages.currentPage().getParameters().put('widgetId', w1.Id);
		ApexPages.currentPage().getParameters().put('target', 'inventory');
		controller.updateWidget();		
		
		//Move inventory widget to deployed
		//Set page params, updated widget
		ApexPages.currentPage().getParameters().put('widgetId', w2.Id);
		ApexPages.currentPage().getParameters().put('target', 'install');
		controller.updateWidget();	
				
		//Test cancel button
		system.assertEquals(controller.cancel().getURL(),'/'+acct.Id);
	
		Test.stopTest();
		
		//Assert that widgets where moved and statuses where updated correctly.
		Widget__c w1after = [select Account__c, Status__c from Widget__c where Id = :w1.Id];
		system.assertEquals(w1After.Account__c,null);
		system.assertEquals(w1After.Status__c,'Inventory');
		
		Widget__c w2after = [select Account__c, Status__c from Widget__c where Id = :w2.Id];
		system.assertEquals(w2After.Account__c,acct.Id);
		system.assertEquals(w2After.Status__c,'Deployed');
		
    }
}