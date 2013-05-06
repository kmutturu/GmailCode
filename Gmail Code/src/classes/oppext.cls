public with sharing class oppext {

    opportunity opp;
    
     public ApexPages.StandardController stdCtrl {get; set;}
     public Boolean refreshPage {get; set;}
    public oppext(ApexPages.StandardController controller) {
    
        stdCtrl = controller;
       
    }


    public pagereference savethis(){
         opp = (opportunity) stdCtrl.getrecord();
      refreshPage=true;
  upsert opp;
   
                return null;
    }
}