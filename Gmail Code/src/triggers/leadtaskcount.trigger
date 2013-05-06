trigger leadtaskcount on Task (after insert,after delete) {

    
        list<id> lstids = new list<id>();
        if(trigger.isInsert){
            for(task objtask : trigger.new){
                if(string.valueOf(objtask.whoid).contains('00Q'))
                    lstids.add(objtask.whoid);
            }
        }
        if(trigger.isDelete){
            for(task objtask : trigger.old){
                if(string.valueOf(objtask.whoid).contains('00Q'))
                    lstids.add(objtask.whoid);  
            }
        }
        list<lead> lstleads = new list<lead>();
        list<lead> lstupdatelead = new list<lead>();
        if(lstids.size() > 0)
            lstleads = [select id,(select id from tasks) from lead where id in :lstids];        
        if(lstleads.size() > 0){
            for(lead obj : lstleads){
                integer i = obj.tasks.size();
                if(i > 0)
                    obj.Total_Activites__c = i;
                else
                    obj.Total_Activites__c = 0;
                lstupdatelead.add(obj);
                    
            }//eof for loop
            if(lstupdatelead.size() > 0){
                system.debug('lstupdatelead'+lstupdatelead);    
                update lstupdatelead;
            }
        }//eof if size
    
 
}//eof trigger