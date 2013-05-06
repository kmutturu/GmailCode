public with sharing class AjaxTestClass
{

    public AjaxTestClass() {

    }

    
    public AjaxTestClass(ApexPages.StandardController controller) {

    }

    String aname;
    String phone;

    List<Account> lstAccounts;
    
    public String getAccounts()
    {
        return aname;
    }
    
    public void setAccounts(string name)
    {
        //if(aname != '')
        aname = name;
    }
    public String getphone()
    {
        system.debug(aname);
        if(aname!=null && aname!='')
        {
            Account objacc = [select id,phone from Account where name =: aname LIMIT 1];
            phone = objacc.phone;
        }
        return phone;
    }

    public void setphone(string phone)
    {
    
    }
    public List<selectOption> getAccountName()
    {
        List<selectOption> options = new List<selectOption>();
        
        lstAccounts = [select Id,name from Account];
        
        options.add(new SelectOption('','--Select One--'));
        
        for(Account objacc : lstAccounts)
        {
            if(objacc.name == 'GenePoint')
                aname = objacc.name;
            options.add(new SelectOption(objacc.name,objacc.name));
        }
        return options;
    }
    
    public pagereference test()
    {
        
        return null;
    }
    
}