trigger UpdateOpportunitySOW on Scope_Of_Work__c (after insert, after update)
{
List<id> oppIds=new List<id>();
for (Scope_of_Work__c sow : trigger.new)
{
   oppIds.add(sow.opportunity__c);
}
Map<Id, Opportunity> oppsById=new Map<Id, Opportunity>();
List<Opportunity> opps= [select id from Opportunity WHERE id in :oppIds];
oppsById.putAll(opps);

List<Opportunity> oppsToUpdate=new List<Opportunity>();
for (Scope_of_Work__c sow : trigger.new)

   {   
       Opportunity opp=oppsById.get(sow.Opportunity__c);
       //opp.SOW__c = sow.id;
       oppsToUpdate.add(opp);
   }

update oppsToUpdate;
}