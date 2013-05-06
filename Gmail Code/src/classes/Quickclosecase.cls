public class Quickclosecase {
 
     ApexPages.StandardController stdctrl;
    public Quickclosecase(ApexPages.StandardController controller){
        stdctrl = controller;
    }
   case oCase;
 
 
   public case getcase(){
     
     oCase = [select id,Priority , status,CaseNumber  from Case where id = :ApexPages.currentPage().getParameters().get('id')];
 
     if(oCase == null)  oCase= new Case();
 
       return oCase;              
   }
 
    public pagereference quickclose(){
    if(ocase.Id!= null){
      oCase.Status='Closed';
    } 
    update oCase;
 
    PageReference casePage = new ApexPages.StandardController(oCase).view();
        casePage.setRedirect(true);
        return casePage ;
    }
     public pagereference save(){
       system.debug('in to save');
       update oCase;
       PageReference casePage = new ApexPages.StandardController(oCase).view();
        casePage.setRedirect(true);
        return casePage ;
     }
 
    }