trigger insertcheck123 on contact (before insert) {

    set<string> snames = new set<string>();
    
    for(contact act : trigger.new){
        snames.add(act.lastname);
    }

    map<string,contact> mapacts = new map<string,contact>();
    
    for(contact act:[select id,lastname from contact where name in :snames]){
        if(mapacts.get(act.lastname) == null)
            mapacts.put(act.lastname,act);
    }
    
    system.debug(mapacts);
    
    for(contact act : trigger.new){
    
        system.debug('&&&&'+act.lastname+'********'+mapacts.get(act.lastname));
        if(mapacts.get(act.lastname) != null){
            act.Sms_opt_out__c= true;
        }
                    
    }
    
    
    
    
     
    

}