trigger contrig on Contact (before insert, before update)
{

Map<String, Contact > conMap = new Map<String, Contact >();

    for (Contact c : System.Trigger.new){
    
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
     for (contact contact : [SELECT mobilephone FROM contact
                      WHERE mobilephone IN :conMap.KeySet()]) {
        contact newcontact = conMap.get(contact.mobilephone);
        newcontact.mobilephone.addError('A contact with this mobilephone '
                               + 'address already exists.');
    }
}