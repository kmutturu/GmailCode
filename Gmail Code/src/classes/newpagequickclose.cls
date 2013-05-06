public class newpagequickclose {
    ApexPages.StandardController con;
    public newpagequickclose(ApexPages.StandardController controller) {
    con = controller;
    }
 
    public PageReference save() {
        con.save();
        return con.view();
    }
    public Pagereference quickclose(){
     system.debug(con.getRecord());
     case obj = (case) con.getrecord();
     
     obj.status = 'Closed';
     insert obj;
     PageReference casePage = new ApexPages.StandardController(obj).view();
        casePage.setRedirect(true);
        return casePage ;
    // string strpgf = 'https://ap1.salesforce.com/'+objcase.id;
 
       // pagereference pgf = new pagereference(strpgf);
 
       // return pgf;
 
 
    }
}