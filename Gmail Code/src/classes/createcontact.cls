public class createcontact{

    public string conval{get;set;}
    
    public createcontact(){
        system.debug(apexpages.currentpage().geturl());
    }
    
    
    public pagereference createcontact(){
        
        contact objcontact = new contact();
        objcontact.lastname = conval;
        insert objcontact;
        
        string strpgf = 'https://ap1.salesforce.com/'+objcontact.id;
        pagereference pgf = new pagereference(strpgf);
        return pgf;
        
        
        
    
    }


}