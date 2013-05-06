global class AccountBatch implements Database.Batchable<sObject>{


    datetime dt;
    global AccountBatch(){    dt= system.now();}
 
    global Database.QueryLocator start(Database.BatchableContext BC){

        return Database.getQueryLocator('SELECT id,name FROM Account');
    }
 
    global void execute(Database.BatchableContext BC, List<sObject> scope){
        List<Account> updateAccts = new List<Account>();
      for(Sobject s : scope)
      {
          Account a = (Account) s;
          a.Name = a.Name + 'Batch 2.';
          updateAccts.add(a);
      }      
      update updateAccts;
    }
 
    global void finish(Database.BatchableContext BC){
        system.debug('***********'+dt);
    }
 
}