trigger randomnumber on Task (before update) {
  
    Profile pf = [select id from profile where name = 'System Administrator' limit 1];

    for(Task objTask : trigger.new){
        
            Task objOldTask = Trigger.oldMap.get(objTask.Id);
            system.debug('old'+objOldTask.activitydate);
            system.debug('new'+objTask.activitydate);
        if(objOldTask.activitydate != objTask.activitydate){
            system.debug('old owner'+objOldTask.ownerid);
            system.debug('new owner'+objTask.ownerid);
            system.debug('profile id'+pf.id+'user profile'+userinfo.getProfileId());
            if(objTask.createdbyId == userinfo.getuserid() ||  pf.id == userinfo.getProfileId()){
            }
            else{
                objTask.addError('Insufficient Privilages');
            }
        }
    }


}