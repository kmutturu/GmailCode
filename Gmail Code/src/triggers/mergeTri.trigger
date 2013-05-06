trigger mergeTri on Contact (before insert,before delete,after delete) {



    if(trigger.isAfter){
        if(trigger.isdelete){
            if(trigger.old[0].MasterRecordId != null)
                trigger.old[0].addError('Merge delete not possible');
        }
    }

}