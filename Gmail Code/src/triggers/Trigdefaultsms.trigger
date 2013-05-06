trigger Trigdefaultsms on SMS_Gateway__c (After insert,After update) {
    sms_gateway__c obj=trigger.new[0];
    list<SMS_Gateway__c> lstsmsgateway=new list<SMS_Gateway__c >();
    lstsmsgateway=[select id ,default__c from  SMS_Gateway__c where default__c=true];
    for(integer i=0;i<lstsmsgateway.size();i++){
        if(lstsmsgateway[i].id !=obj.id )
        {
        lstsmsgateway[i].default__c=false;
        update lstsmsgateway;
        }
        
    }
   
}