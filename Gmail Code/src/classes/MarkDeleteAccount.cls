public class MarkDeleteAccount{

 public MarkDeleteAccount(ApexPages.StandardController controller) {
    Acc = new Account(id = Apexpages.Currentpage().getParameters().get('id'));
        Acc.Mark_for_Delete__c = true;
        
  
  }
  
Public Account Acc {get;set;}
    
    public PageReference save(){     
       update Acc;
        PageReference returnPage = new PageReference('/' + ApexPages.currentPage().getParameters().get('id'));
        returnPage.setRedirect(true);
        return returnPage;
        
    
    }
    public PageReference Cancel() {
        PageReference returnPage = new PageReference('/' + ApexPages.currentPage().getParameters().get('id'));
        returnPage.setRedirect(true);
        return returnPage;
        
    }
  
    }