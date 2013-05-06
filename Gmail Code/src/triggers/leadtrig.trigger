trigger leadtrig on Lead (before insert, before update)
{

Map<String, Lead > conMap = new Map<String, Lead >();

    for (Lead c : System.Trigger.new){
    
        if (c.mobilephone!= null){ 
        
            if ( System.Trigger.isInsert ||(System.Trigger.isUpdate && c.mobilephone!= System.Trigger.oldMap.get(c.Id).mobilephone)) {
        
                if (conMap .containsKey(c.mobilephone)) {
                
                   c.mobilephone.addError('Mobile Phone already Exists');
                        
                } 
                
                else {        
                        conMap.put(c.mobilephone, c);
                }
        
            }
        
        }
    }
     for (Lead Lead : [SELECT mobilephone FROM Lead
                      WHERE mobilephone IN :conMap.KeySet()]) {
        Lead newLead = conMap.get(Lead.mobilephone);
        newLead.mobilephone.addError('A Lead with this mobilephone '
                               + 'address already exists.');
    }
}