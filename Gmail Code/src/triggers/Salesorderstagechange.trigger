trigger Salesorderstagechange on Sales_Order__c (after insert, after update) {
	/*list<Sales_Order__c> lstconsider = new list<Sales_Order__c>();
	list<string> lstEmailids = new list<string>();
	set<id> salesordids = new set<id>();
	set<id> saccountids = new set<id>();
	set<id> soppids = new set<id>();
	for(Sales_Order__c objsalesorder : trigger.new){
		if(objsalesorder.Sales_Order_Stage__c == '2-Submitted' || objsalesorder.Sales_Order_Stage__c == '2-Submitted with Fulfillment'){
			salesordids.add(objsalesorder.id);
			saccountids.add(objsalesorder.Account_Name__c);
			soppids.add(objsalesorder.Opportunity_Name__c);				
		}//eof if
	}//eof for
	
	for(Sales_Order_Credit__c objsalescredit : [select useremailid__c from Sales_Order_Credit__c where Sales_Order__c in :salesordids]){
		lstEmailids.add(objsalescredit.useremailid__c);
	}
	for(AccountTeamMember objact : [select user.email from AccountTeamMember where AccountId in :saccountids]){
		lstEmailids.add(objact.user.email);
	}
	for(OpportunityTeamMember objopp : [select user.email from OpportunityTeamMember where OpportunityId in :soppids]){
		lstEmailids.add(objopp.user.email);
	}
	
	system.debug('mails'+lstEmailids);
	
	Messaging.SingleEmailMessage mail = new Messaging.SingleEmailMessage();
	//String[] toAddresses = new String[] {'user@acme.com'};
	mail.setToAddresses(lstEmailids);
	mail.setSubject('Please Verify Sales Order Credit for Account Name');
	mail.setPlainTextBody('Test Body Message');
	Messaging.sendEmail(new Messaging.SingleEmailMessage[] { mail });*/
	if(trigger.new.size() == 1 && (trigger.new[0].Sales_Order_Stage__c == '2-Submitted' || trigger.new[0].Sales_Order_Stage__c == '2-Submitted with Fulfillment')){
		list<string> lstEmailids = new list<string>();
		for(Sales_Order_Credit__c objsalescredit : [select useremailid__c from Sales_Order_Credit__c where Sales_Order__c = :trigger.new[0].id]){
			lstEmailids.add(objsalescredit.useremailid__c);
		}
		for(AccountTeamMember objact : [select user.email from AccountTeamMember where AccountId =  :trigger.new[0].Account_Name__c]){
			lstEmailids.add(objact.user.email);
		}
		for(OpportunityTeamMember objopp : [select user.email from OpportunityTeamMember where OpportunityId = :trigger.new[0].Opportunity_Name__c]){
			lstEmailids.add(objopp.user.email);
		}
		
		system.debug('mails'+lstEmailids+'name'+trigger.new[0].Account_Name__r.name);
		
		Messaging.SingleEmailMessage mail = new Messaging.SingleEmailMessage();
		//String[] toAddresses = new String[] {'user@acme.com'};
		mail.setToAddresses(lstEmailids);
		mail.setSubject('Please Verify Sales Order Credit for '+ trigger.new[0].actname__c);
		mail.setPlainTextBody('Test Body Message');
		Messaging.sendEmail(new Messaging.SingleEmailMessage[] { mail });
	}//eof size
		
}//eof trigger