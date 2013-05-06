public class t
{
    public List<SelectOption> myList {get; set;}
    public boolean showAccount {get; set;}
    public boolean showContact {get; set;}
    public String SelectedVal {get; set;}
    
    public t()
    {
        myList = new List<SelectOption>() ;
        myList.add(new SelectOption('Account' , 'Account')) ;
        myList.add(new SelectOption('Contact' , 'Contact')) ;
        
        showAccount = false ;
        showContact = false ;
        SelectedVal = '' ;
    }
    
    public PageReference RenderSec()
    {
        if(SelectedVal == 'Account')
        {
            showAccount = true ;
            showContact = false ;
        }
        if(SelectedVal == 'Contact')
        {
            showAccount = false ;
            showContact = true ;
        }
        return null ;
    }
}