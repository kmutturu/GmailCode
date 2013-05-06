/*Trigger Name : SMSTrigger
* Author : Charan & Jaya Lakshmi
* Date : 02nd Feb 2011
* Purpose: To fire whenever a task is inserted or updated.
* Modification History :
*
*/


trigger SMStasktrigger on task ( before insert,before update,after Insert, after update) {

// Delete object creation

    List<user> lstUsers = new List<user>();
    List<Id> lsttaskIds = new List<Id>();
    Map<Id,String> mapUserPhone = new Map<Id,String>();
    
    User objuser1 = new User();

//Insert a task into the task object which was inserted
    task objtask= trigger.new[0];

    try{
        if(trigger.isbefore)
        {
            if(trigger.isinsert ||trigger.isupdate){
                 for(task objtask1:trigger.new)
                {
                    lsttaskIds.add(objtask1.ownerId);
                }
                lstUsers = [Select id,mobilephone from user where id in:lsttaskIds];
                system.debug('User info******'+lstUsers);
                for(User objUser:lstUsers)
                {
                    mapUserPhone.put(objUser.Id,objUser.mobilePhone);
                }
                system.debug('Map**********'+mapUserPhone);
                for(task objtask1:trigger.new)
                {
                    if(objtask1.send_sms__c == true && mapUserPhone.get(objtask1.ownerId) == null && objtask1.Type!='Bulk SMS')
                        objtask1.addError('No Phone specified on selected user');
                }
            }//end of if
        }// eof before trigger

        if(trigger.isAfter){
            if((trigger.isUpdate ||trigger.isInsert)&& objtask.send_sms__C==true )
            {
                //if send sms on task layout is true
                //if(objtask.send_sms__C==true)
                //{

                    objuser1=[Select id,mobilephone from user where id=:objtask.ownerid];
                //}//end of if

                //calling a class and passing task subject and Contact phone as Arguments
                sendsmscallout.sendSmsMethod(objtask.subject,objtask.description, objuser1.mobilephone);
                system.debug('@@@'+objtask.description);
                system.debug('@@@'+objuser1.mobilephone);
            }//end of if
        }//eof is after insert or update trigger
    }//EOF TRY


    catch( QueryException e ) {
        System.debug( e.getMessage() );

    }//end of catch
}// end of trigger