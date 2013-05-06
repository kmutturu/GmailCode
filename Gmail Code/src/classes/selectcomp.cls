public class selectcomp{

    public list<selectoption> getResults(){
    
        list<selectoption> lstoptions = new list<selectoption>();
        
        for(Account obj : [select id,name from account]){
        
                lstoptions.add(new selectoption(obj.id,obj.name)); 
        }
        
        return lstoptions;
    
    }
    
    
    public pagereference doit(){
        return null;
    }
    
    public string radioval{get;set;}
    list<string> selectedval = new list<string>();
    
    public list<string> getselectedval(){
        system.debug('selectedval '+selectedval );
        list<account> lstact = [select phone from account where id  = :radioval];
        list<string> lstphones = new list<string>();
        system.debug('lstact  '+lstact);
        for(account obj : lstact)
            lstphones.add(obj.phone);
        return lstphones ;
    }
    public void setselectedval(list<string> value){
         system.debug('value'+value);
        selectedval = value;
    }

}