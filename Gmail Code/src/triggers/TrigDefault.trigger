/*Trigger Name : TrigDefault
* Author : Charan & Jaya Lakshmi
* Date : 21st Feb 2011
* Purpose: To fire whenever make a gateway as default and already one default gateway is there
* Modification History :
*
*/




trigger TrigDefault on SMS_Gateway__c (Before insert, before update) {

//creation of list object of type SMS_Gateway__c

    list<SMS_Gateway__c > lstgateway=[select name from SMS_Gateway__c where default__c =:true];

    
    for(SMS_Gateway__c obj: trigger.new){
        if(lstgateway.size()>0 && obj.default__c==true && obj.id != lstgateway[0].id)
        obj.default__c.addError('Already Default Checkbox is Selected on Other Gateway, Kindly Uncheck it and try again...');
       
        if(obj.default__c==true&&obj.active__c==false)
        obj.addError('This gateway is not active. A gateway has to be active for it to be desginated as the default. Make the gateway active and try again.');
    }
}