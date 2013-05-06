public with sharing class UploadRecordUsingCSV {
    
    public Blob FileRecords{get;set;}
    String[] LineNo=new String[]{};
    List<Unit_code__c> AllUnit;
    Public Pagereference UploadFile()
     {
         system.debug('enetered');
       String FileData=FileRecords.toString();
       LineNo=FileData.split('\n');
       AllUnit = new List<Unit_code__c>();
                system.debug('enetered****'+AllUnit);
       for(Integer i=1;i<LineNo.size();i++)
        {
          Unit_code__c con=new Unit_code__c();
          String[] ActualData=new String[]{};
          ActualData=LineNo[i].split(',');
          con.Name__c=ActualData[0];
          con.partyid__c = ActualData[1]; 
          AllUnit.add(con);
        }
       try
       {
           
         insert AllUnit;
       } 
       catch(Exception e) 
        {
        system.debug(e.getMessage());
        }
       return Null;
     }
}