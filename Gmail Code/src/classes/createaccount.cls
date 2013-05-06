public class createaccount{

    public string txtval{get;set;}
    
    
    public void dothecal(){
        contact obj = new contact();
        obj.lastname = txtval;
        insert obj;
    }
}