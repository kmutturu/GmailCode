public class accountsearch{
    
    public string strval{get;set;}
    
    
   /* boolean assig = false;
    
    public void setassig(boolean value){
        assig = value;
    }
    
    public boolean getassig(){
        return assig;
    }*/
    
    public boolean assig{
        get{
        system.debug('assign'+assig);
        return assig;
        }set;
    }
    
    list<Account> lstAcct;
    
    public void dosearch(){
    
     string newval = '%' + strval + '%';
    
     system.debug('strval'+strval);
     lstacct    = [select id,name from Account where name like :newval];
     if(lstacct.size() > 0)
         assig = true;
    }
    
    public list<Account> getlstAct(){
    system.debug('lstacct'+lstacct+'assig'+assig);
     return lstacct;    
    }
}