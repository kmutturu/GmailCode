trigger getowner on Lead (before insert,before update) {

     map<id,list<lead>> muids = new map<id,list<lead>>();
     map<id,list<lead>> mqids = new map<id,list<lead>>();
    
     for(lead objLead : trigger.new){
         if(string.valueOf(objLead.ownerid).contains('005')){
             if(muids.get(objLead.ownerid) == null){
                 list<lead> lstL = new list<lead>();
                 lstL.add(objLead);
                 muids.put(objlead.ownerid,lstL);
             }
             else{
                 list<lead> lstL = new list<lead>();
                 lstL = muids.get(objLead.ownerid); 
                 lstL.add(objLead);
                 muids.put(objlead.ownerid,lstL); 
             }
                 
         }
         if(string.valueOf(objLead.ownerid).contains('00G')){
             if(mqids.get(objLead.ownerid) == null){
                 list<lead> lstL = new list<lead>();
                 lstL.add(objLead);
                 mqids.put(objlead.ownerid,lstL);
             }
             else{
                 list<lead> lstL = new list<lead>();
                 lstL = mqids.get(objLead.ownerid); 
                 lstL.add(objLead);
                 mqids.put(objlead.ownerid,lstL); 
             }
                 
         }
     }
     
     map<id,user> mUser = new map<id,user>([select id,name from user where id in :muids.keyset()]);
     map<id,Group> mGroup = new map<id,Group>([select id,name from Group where id in :mqids.keyset()]);
     
     for(id iUser : muids.keyset()){
         list<lead> lstL = new list<lead>();
         lstL = muids.get(iUser);
         if(mUser.get(iUser) != null){
             for(Lead objLead : lstL){
                 objLead.ownername__c = mUser.get(iUser).name;
             }
         }
     }
     for(id iUser : mqids.keyset()){
         list<lead> lstL = new list<lead>();
         lstL = mqids.get(iUser);
         if(mGroup.get(iUser) != null){
             for(Lead objLead : lstL){
                 objLead.ownername__c = mGroup.get(iUser).name;
             }
         }
     }        
     //system.debug('mUser'+mUser);
     //system.debug('mGroup'+mGroup);
     
}