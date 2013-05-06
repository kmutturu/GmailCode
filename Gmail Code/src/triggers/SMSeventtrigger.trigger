/*Trigger Name : SMSTrigger
* Author : Charan & Jaya Lakshmi
* Date : 02nd Feb 2011
* Purpose: To fire whenever a event is inserted or updated.
* Modification History :
*
*/


trigger SMSeventtrigger on event ( before insert,before update,after Insert, after update) {

// Delete object creation

    List<user> lstUsers = new List<user>();
    List<Id> lsteventIds = new List<Id>();
    Map<Id,String> mapUserPhone = new Map<Id,String>();
    
    User objuser1 = new User();

//Insert a event into the event object which was inserted
    event objevent= trigger.new[0];

    try{
        if(trigger.isbefore)
        {
            if(trigger.isinsert ||trigger.isupdate){
                 for(event objevent1:trigger.new)
                {
                    lsteventIds.add(objevent1.ownerId);
                }
                lstUsers = [Select id,mobilephone from user where id in:lsteventIds];
                system.debug('User info******'+lstUsers);
                for(User objUser:lstUsers)
                {
                    mapUserPhone.put(objUser.Id,objUser.mobilePhone);
                }
                system.debug('Map**********'+mapUserPhone);
                for(event objevent1:trigger.new)
                {
                    if(objevent1.send_sms__c == true && mapUserPhone.get(objevent1.ownerId) == null && objevent1.Type!='Bulk SMS')
                        objevent1.addError('No Phone specified on selected user');
                }
            }//end of if
        }// eof before trigger

        if(trigger.isAfter){
            if((trigger.isUpdate ||trigger.isInsert)&& objevent.send_sms__C==true )
            {
                //if send sms on event layout is true
                //if(objevent.send_sms__C==true)
                //{

                    objuser1=[Select id,mobilephone from user where id=:objevent.ownerid];
                //}//end of if

                //calling a class and passing event subject and Contact phone as Arguments
                sendsmscallout.sendSmsMethod(objevent.subject,objevent.description, objuser1.mobilephone);
                system.debug('@@@'+objevent.description);
                system.debug('@@@'+objuser1.mobilephone);
            }//end of if
        }//eof is after insert or update trigger
    }//EOF TRY


    catch( QueryException e ) {
        System.debug( e.getMessage() );

    }//end of catch
}// end of trigger