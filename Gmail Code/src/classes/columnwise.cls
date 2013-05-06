public class columnwise{



    public list<jkasdh__c> lstnames{get;set;}
    
    
    public columnwise(){
        lstnames = [select name from jkasdh__c];
        
    }



}