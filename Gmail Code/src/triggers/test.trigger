trigger test on Unit_code__c (before insert) {


contact obj = new contact();
obj.lastname = 'dummy';
insert obj;


for(Unit_code__c  obj1 : trigger.new){
    if(obj1.status__c == 'Sold')
        trigger.new[0].addError('eneter');
}

}