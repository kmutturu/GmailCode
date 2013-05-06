trigger insertcheck on Account (before insert) {

    set<string> snames = new set<string>();
    
    for(account act : trigger.new){
        snames.add('****'+act.name);
    }

    map<id,account> mapacts = new map<id,account>([select id,name from account where name in :snames]);
    
    system.debug(mapacts);
    
    for(account act : trigger.new){
        system.debug('&&&&'+mapacts.get(act.id));
        if(mapacts.get(act.id) != null){
            act.isActiveHarvestClient__c = true;
        }
                    
    }
    
    
    
    
     
    

}