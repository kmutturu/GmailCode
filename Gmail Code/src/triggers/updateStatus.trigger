trigger updateStatus on Quote (before update)
{
   
   
   
   for(Quote q : trigger.new)
   {        
      if((q.no_of_persons__c != trigger.oldMap.get(q.id).no_of_persons__c) && (q.no_of_persons__c >= 2))
           q.Status = '3';
   }
}