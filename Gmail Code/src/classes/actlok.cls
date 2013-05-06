public with sharing class actlok {


contact act = new contact();
    public actlok(ApexPages.StandardController controller) {
    
        act = (contact)controller.getrecord();
    }
    
       

    public pagereference clicke(){
        insert act;
         PageReference acctPage = new ApexPages.StandardController(act).edit();
          acctPage.setRedirect(true); 
          return acctPage;
    }
}