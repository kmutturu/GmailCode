global with sharing class ScheduleMyClass implements schedulable{

    global void execute(SchedulableContext sc){
        
        datetime dt = system.now();
        system.debug(dt.minute());    
        string str = string.valueOf(dt.minute()+1);
        string cron = '0 '+str+' * * * ?';
        system.debug(cron);
        ScheduleMyClass objs = new ScheduleMyClass();
        system.schedule('teet',cron,objs); 
        Account obj = new Account();
        obj.name = 'test schedule account new timwe';
        insert obj;
    }
    }