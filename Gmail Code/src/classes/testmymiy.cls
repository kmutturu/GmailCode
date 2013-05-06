@istest
private class testmymiy{

    static testmethod void tetststs(){
    
    
          aaaa__c  objScheduleHourlyReport = new aaaa__c();       
          objScheduleHourlyReport.Status__c = 'Open';
          objScheduleHourlyReport.Expiry_Date__c = system.today()-2;
          insert objScheduleHourlyReport;
        Test.startTest();

        String jobId = System.schedule('testBasicScheduledApex1',
        '0 55 * * * ?', new BIPL_fffff());
        
        CronTrigger ct = [SELECT id, CronExpression, TimesTriggered, NextFireTime
        FROM CronTrigger WHERE id = :jobId];
        
        System.assertEquals(0, ct.TimesTriggered);
        Test.stopTest();
    }
}