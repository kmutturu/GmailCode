public with sharing class WidgetManagerController {

    public Account acct {get; set;}
    List<Widget__c> installedWidgets;
    List<Widget__c> inventoryWidgets;
    
    //-------------Contructor and Get Methods---------------------
    public WidgetManagerController(){
        //Get basic information from related account
        acct = [select Id, Name, AccountNumber, BillingCity, Type from Account where Id = :ApexPages.CurrentPage().getParameters().get('id')];
    }
    
    //Getter Methogds   
    public List<Widget__c> getInstalledWidgets(){
        if(installedWidgets == null){
            installedWidgets = new List<Widget__c>();
            installedWidgets = [select Id, Name, Account__c, Status__c, Serial_Number__c from Widget__c where Account__c = :acct.Id order by LastModifiedDate];    
        }
        return installedWidgets;
    }
    
    public List<Widget__c> getInventoryWidgets(){
        if(inventoryWidgets == null){
            inventoryWidgets = new List<Widget__c>();
            inventoryWidgets = [select Id, Name, Account__c, Status__c, Serial_Number__c from Widget__c where OwnerId = :UserInfo.getUserId() AND Account__c = null order by LastModifiedDate];    
        }
        return inventoryWidgets;
    }
    
    public void updateWidget(){
        Id widgetId = ApexPages.CurrentPage().getParameters().get('widgetId');
        String target = ApexPages.CurrentPage().getParameters().get('target');
        
        Widget__c w = [select Id, Account__c, Status__c from Widget__c where ID = :widgetID]; //new Widget__c(Id = widgetId);
        if(target == 'install'){
            w.Account__c = acct.Id;
            w.Status__c = 'Deployed';
        }else{
            w.Account__c = null;
            if(w.status__c != 'Maintenance Required') w.Status__c = 'Inventory';
        }
        update w;
        
        //Requery widget lists
        installedWidgets = null;
        inventoryWidgets = null; 
    }

    public PageReference cancel(){
        PageReference p = new PageReference('/'+acct.Id);
        p.setRedirect(true);
        return p;
    }
}