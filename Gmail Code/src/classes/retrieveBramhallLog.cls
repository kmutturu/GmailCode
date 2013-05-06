public class retrieveBramhallLog 
 {
  private ApexPages.StandardSetController controller; 
  
    public String getTerminalName() 
    {
        return 'Bramhall';
        return 'Time_Flag__c';
    }

    public List<Daily_Log__c> getDailyLog()
    {
                return [SELECT Id, Name FROM Daily_Log__c
                        WHERE Terminal__r.Name = 'Bramhall' limit 10];
    }
 
     public List<Daily_Log__c> getOutbaseLog()
    {
                return [SELECT Id, Name  FROM Daily_Log__c
                        WHERE Terminal__r.Name = 'Bramhall' AND (Time_Flag__c = 1 OR weekend_check__c = 1) limit 10];
    }
  }