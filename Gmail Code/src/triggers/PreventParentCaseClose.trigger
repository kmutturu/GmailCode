trigger PreventParentCaseClose on Case (before update) {
   
    if(trigger.isUpdate && trigger.new[0].parentid == null && [select count() from case where parentid = :trigger.new[0].parentid and (status = 'Clsoed' or status = 'Declined')] > 0)
        trigger.new[0].Child_Case_Open__c = false;
    
 }