trigger leadobjTrigger on Lead (before insert) {

       /* Set<ID> keycodes = new Set<ID>();
    for (Lead leadobj : Trigger.new) 
        keycodes.add(leadobj.Keycode__c);
system.debug('*******'+keycodes);
   
        Map<string,string> entries = new Map<string,string>();
                
        List<Campaign> lstcampaign=[select  Keycode__c,Name from Campaign 
         where Keycode__c in :keycodes];
                if(lstcampaign!=null & lstcampaign.size()>0){
                    for(Campaign obj:lstcampaign)
                                entries.put(obj.Keycode__c,obj.name);
                }
         
     for (Lead leadobj : Trigger.new) 
        leadobj.Campaign_Name__c = entries.get(leadobj.Keycode__c);  */
        
    //variable to hold store number    
    string storeNumber;
    
    //for loop to go through new trigger instances and assign Dealer_Number__c to store variable
    for(Lead l : Trigger.new)        
        storeNumber = l.ealer_Number__c;
   
    //SOQL query to find account account(store) id from the account(store) that has the same AccountNumber as lead store number
    account a = [SELECT id FROM Account WHERE AccountNumber = :storeNumber limit 1];
        
    //for loop to go through trigger and assign account(store) id to lead lookup field Dealer__c
    for(Lead l : Trigger.new)
        l.GC_Product__c = a.id; 
              

}