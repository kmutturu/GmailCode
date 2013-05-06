public class multiAccountInsert{

    public List<Account> accts {get; set;}
    
    public multiAccountInsert(){
        accts = new List<Account>();
        accts.add(new Account());
    }
    
    public void addrow(){
        accts.add(new Account());
    }
    
    public PageReference save(){
        insert accts;
        PageReference home = new PageReference('/home/home.jsp');
        home.setRedirect(true);
        return home;
    }
}