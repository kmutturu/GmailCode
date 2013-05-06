public class MassCreation{
    public List<Case> Cases {get; set;}
    
    public MassCreation(){
        Cases = new List<Case>();
        Case CaseAdd = new Case();
        
        if(Apexpages.Currentpage().getParameters().get('ID')!=null) {
            CaseAdd.ContactID = Apexpages.Currentpage().getParameters().get('id');
        }
      
        //accts.add(new Opportunities_Line_Item__c());
        Cases.add(CaseAdd);
        
    }
    public void addrow(){
        Case CaseAdd;
        if (cases.size()>0)
        {
           caseAdd=cases[cases.size()-1].clone(false, true);
        }
        else 
        {
           CaseAdd=new Case();
           if(Apexpages.Currentpage().getParameters().get('ID')!=null)    {
              CaseAdd.ContactID = Apexpages.Currentpage().getParameters().get('id');
           }
         }
         Cases.add(CaseAdd);
        //accts.add(new Opportunities_Line_Item__c());
    }
   public PageReference deleteRow() {
   if (cases.size()>1)
   {
      cases.remove(Cases.size()-1);
   }
 return null;
 }
    public PageReference save(){
        insert Cases;
        PageReference home = new PageReference('/' + ApexPages.currentPage().getParameters().get('id'));
        home.setRedirect(true);
        return home;
    }
    public PageReference Cancel() {
        PageReference returnPage = new PageReference('/' + ApexPages.currentPage().getParameters().get('id'));
        returnPage.setRedirect(true);
        return returnPage;
    }
    }