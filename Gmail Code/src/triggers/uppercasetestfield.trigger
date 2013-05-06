trigger uppercasetestfield on Account (before insert,before update) {
    try{
   // List<Account> acc=[Select id,name from Account acc where id in:Trigger.new];
    for(Account a:trigger.new)
    {
        if(a.Distribution_Channel__c!=null)
        {
            a.Distribution_Channel__c=a.Distribution_Channel__c.toUpperCase();
        }
    
    }
    
    }
    catch(Exception e)
    {
    System.debug(e);
    }
}