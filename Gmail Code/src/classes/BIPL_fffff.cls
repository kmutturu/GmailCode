global class BIPL_fffff implements Schedulable{
   global void execute(SchedulableContext sc){
  
     List<AAAA__c> permits = [Select Id from AAAA__c where (Status__c='Open' OR Status__c='Pending' OR Status__c='Processing') and Expiry_Date__c<:System.today()];
      if(permits.size()>0)  {
         for(AAAA__c p:permits){
            p.Status__c='Expired';
         }
         update permits;
      }
   }
}