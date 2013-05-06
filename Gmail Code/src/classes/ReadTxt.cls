public with sharing class ReadTxt{
    
    public Blob FileRecords{get;set;}
    String[] LineNo=new String[]{};
    public string type{get;set;}
    
    Public Pagereference UploadFile()
     {
       system.debug('enetered'+type);
       String FileData=FileRecords.toString();
       LineNo=FileData.split('\n');
       system.debug('enetered****'+Lineno);
       for(Integer i=0;i<LineNo.size();i++)
        {
          system.debug(LineNo[i]);
          //String[] ActualData=new String[]{};
          //ActualData=LineNo[i].split(',');
          //system.debug(actualdata[i]);
        }
    
       return Null;
     }
}