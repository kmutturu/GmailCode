global class  AccountView {

    public static Account  acc {get;set;}
    public static String staticActId;
    /*modification message*/
    public AccountView() {
    
    
    system.debug('constructor');
    system.debug('*****'+acc);
    acc = [select Name, Id from Account where Id =: ApexPages.currentPage().getParameters().get('id')];
        staticActId = ApexPages.currentPage().getParameters().get('id');
        
    }
   /* static{
     system.debug('static block');
      acc = [select Name, Id from Account where Id =: ApexPages.currentPage().getParameters().get('id')];
        staticActId = ApexPages.currentPage().getParameters().get('id');
        }*/
    
    
    @RemoteAction
    public static String  changeAccountName(String actId, account Name) {
        //
         //   here I am getting acc "null"
          //  And  ApexPages.currentPage().getParameters().get('id') also "null"
          //  Even "staticActId" is also null when I call from remote Action  
        //
        
        system.debug('******'+acc+'*****'+name);
        
        //Account act = [select Name, Id from Account where Id =: actId];
        //act.Name = Name;
        //update act;
        return 'Update Sucessfully';
    }
}