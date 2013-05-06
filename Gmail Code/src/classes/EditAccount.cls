public class EditAccount
{
    public string propviewdata{ get ; set ;}
    String datetimeStr = '';
    public String propDT { get { return datetimeStr; } set { datetimeStr = value; }}
    public void save(){}
    public void cancel(){}
    List<Contact> con;
    public List<Account> acc;
    public List<Opportunity> opp;
    List<WrapperOpportunity> lstWO = new List<WrapperOpportunity>();
    public string propcontactid { get; set; }
    public string propopportunityid{get;set;}
    public List<Contact> propAllContacts    { get { return con; } set { con = value; } }//End Prop propAllContacts    
    public List<Opportunity> propAllOpportunity    {  get { return opp;}  set { opp = value; } }//End Prop propAllOpportunity
   // private String sortDirection = 'ASC';
   // private String sortExp = 'name';
    public void refresh() 
    {
       datetimeStr = String.valueOf(DateTime.Now()).split(' ')[1];
    }
    public void doSave() 
    {   
        for(account ac : acc)
        {
           update ac;
        }
    }
    public List<Account> getAccount()   
    {
       return (List<Account>) acc; 
    }//End getAccount
    
    public void setAccount(List<Account> Acc)
    {
     this.acc = Acc;
    }  
    public List<WrapperOpportunity> propLstWO { get { return lstWO; } set { lstWO = value; } } 
    public EditAccount() 
    {
        acc = [select id,Name, Phone,BillingCity,CreatedDate from Account limit 1000];
    }//End Constructor
    
    public void GetAllContacts()
    {
        if(propcontactid != null && propcontactid != '')
        {
            if(con != null && con.size() > 0)
                con.clear();
            
            //con = [select id,name,email,title,Languages__c , Level__c,TestCreatedDate__c,Department,Phone from Contact WHERE AccountId =: propcontactid];
            con = [select id,name,email,title,Department,Phone from Contact WHERE AccountId =: propcontactid];
        }
    }//End GetAllContacts
    
    public void GetAllOpportunity()
    {
        if(propopportunityid != null && propopportunityid != '')
        {
             if(lstWO != null && lstWO.size() > 0)
                lstWO.clear();
            if(opp != null && opp.size() > 0)
                opp.clear();
            opp = [SELECT o.id, o.Amount, o.CreatedDate, o.Name, (Select Id, Name From Attachments) FROM Opportunity o  WHERE o.AccountId =: propopportunityid];
            if(opp != null && opp.size() > 0)
            {
               for(Opportunity oo : opp)
                {
                   WrapperOpportunity wo = new WrapperOpportunity();
                   wo.propId = oo.id;
                   wo.propName = oo.name;
                   wo.propAmount = String.valueOf(oo.amount);
                   //wo.propCreatedDate = oo.CreatedDate;
                   if(oo.Attachments != null && oo.Attachments.size() > 0)
                    {
                        String strAttachNames = '';
                        for(Integer j = 0; j < oo.Attachments.size(); j++)
                        {
                           strAttachNames = strAttachNames + oo.Attachments[j].name + ',   ';
                        }
                            wo.propAttachNames = strAttachNames.substring(0,strAttachNames.length()-4);
                   }
                   lstWO.add(wo);
                }
           }
        }
    }//End GetAllOpportunity
    public class WrapperOpportunity
    {
        public String propId { get; set; }
        public String propName { get; set; }
        public String propAmount { get; set; }
        //public String propCloseDate { get; set; }
        public String propAttachNames { get; set; }
    }
}