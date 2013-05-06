trigger automate on Opportunity (before insert) {

    
    set<id> sids = new set<id>();
    for(Opportunity obj : trigger.new){
        sids.add(obj.accountid);
    }
    
    list<Opportunity> lst = [select id,account.name from Opportunity where accountid in :sids]; 
    
    integer i = lst.size();
    
    
    for(integer ival = 0; ival <= i; ival++){
    
        if(ival > 0){
            for(Opportunity obj : trigger.new){
                system.debug('*******'+obj.account.name);
                obj.name = lst[0].account.name+'-'+obj.StageName+'('+ival+')';
            }
        }
    
    }


}