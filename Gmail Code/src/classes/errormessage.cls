public with sharing class errormessage {

    Account act = new account();
    
    public string parentactvalue{get;set;}
    
    public errormessage(ApexPages.StandardController controller) {
    
        act = (account)controller.getRecord();

    }
    
    public pagereference getaccountname(){
            if(parentactvalue != null){
                list<Account> lstActs = [select id from account where name = :parentactvalue];
                    if(lstActs.isempty()){
                        account objact = new account();
                        objact.name = parentactvalue;
                        insert objact;
                    }
            }
            insert act;
            string str = '/'+act.id;
            pagereference pg = new pagereference(str);
            return pg;
    }

}