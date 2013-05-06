@istest
private class testmiii{
    static testmethod void  mjuj(){
        Terminal__c obj1= new Terminal__c();
        obj1.name = 'Bramhall';
        insert obj1;
        
        retrieveBramhallLog obj =  new retrieveBramhallLog();
        obj.getDailyLog();
        obj.getOutbaseLog();
        obj.getTerminalName();
        
    }
}