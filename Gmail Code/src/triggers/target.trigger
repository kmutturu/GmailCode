Trigger target on Opportunity (before update)
{

set<id> sup=new set<id>();
for(opportunity opp:trigger.new)
{

sup.add(opp.accountid);

}
list<account>dry = new list<account>();
Account[]acc=[select id,(select name,amount from opportunities where amount != null order by amount desc limit 1) from account where id in:sup];  
for(account lope:acc)
{
    system.debug('lope.opportunities.size()'+lope.opportunities.size()+'opps'+lope.opportunities);
    if(lope.opportunities.size() > 0){
        system.debug('name'+lope.opportunities[0].name+'amount'+lope.opportunities[0].amount);
        lope.previous_rating__c = lope.opportunities[0].name;
        //System.debug('The value in the variable of tupoe acocunt is'+lope.refereed__c);
        dry.add(lope);
    }
}
update dry;
}