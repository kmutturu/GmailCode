public class selectlist{

    
    public list<selectoption> getoption(){
        list<selectoption> lstoptions = new list<selectoption>();
        
        for(account act : [select id,name from account]){    
                lstoptions.add(new selectoption(act.id,act.name));
        }
        return lstoptions;
    }
    
    list<account> lstAct = new list<account>();
    
    public void setAccts(list<account> value){
        system.debug('value'+value);
        lstAct = value;
    }

    public list<account> getAccts(){
        system.debug('lstAct'+lstAct);
        return lstAct;
    }

    public pagereference savee(){
        return null;
    }

}