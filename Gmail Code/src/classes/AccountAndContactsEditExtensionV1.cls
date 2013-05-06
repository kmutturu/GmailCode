public class AccountAndContactsEditExtensionV1 {
    private ApexPages.StandardController std;
     
    // the associated contacts
   public List<Contact> contacts;
      
    // the chosen contact id - used when deleting a contact
    public Id chosenContactId {get; set;}
     
    public AccountAndContactsEditExtensionV1(ApexPages.StandardController stdCtrl)
    {
     std=stdCtrl;
    }
     
    public Shipment_Request__c getAccount()
    {
     return (Shipment_Request__c) std.getRecord();
    }
 
    private boolean updateContacts()
    {
        boolean result=true;
        if (null!=contacts)
           {
           List<Contact> updConts=new List<Contact>();
              try
              {
               update contacts;
              }
              catch (Exception e)
              {
                 String msg=e.getMessage();
                 integer pos;
                  
                 // if its field validation, this will be added to the messages by default
                 if (-1==(pos=msg.indexOf('FIELD_CUSTOM_VALIDATION_EXCEPTION, ')))
                 {
                    ApexPages.addMessage(new ApexPages.Message(ApexPages.Severity.ERROR, msg));
                 }
                  
                 result=false;
              }
           }
            
           return result;
    }
     
    public PageReference saveAndExit()
    {
     boolean result=true;
    result=updateContacts();
      
     if (result)
     {
        // call standard controller save
        return std.save();
     }
     else
     {
      return null;
     }
    }
     
    public PageReference save()
    {
    	system.debug('lstQueAns'+lstQueAns+'std'+std);
    	 std.save();
     Boolean result=true;
     
     list<contact> lstcon = new list<contact>();
     for(WrapperQueAns obj : lstQueAns){
     	contact objcon = new contact();
     	objcon.lastname = obj.title;
     	objcon.AccountId = getAccount().id;
     	lstcon.add(objcon);
     }
     insert lstcon;
    /* if (null!=getAccount().id)
     {
      result=updateContacts();
     }
     else
     {
      pr.setRedirect(true);
     }
      
     if (result)
     {
        // call standard controller save, but don't capture the return value which will redirect to view page
        std.save();
           ApexPages.addMessage(new ApexPages.Message(ApexPages.Severity.INFO, 'Changes saved'));
     }*/
        //pr.getParameters().put('id', getAccount().id);
      PageReference pr=new pagereference('https://ap1.salesforce.com/'+getAccount().id);
     return pr;
    }
 
   
     public List<WrapperQueAns> lstQueAns = new List<WrapperQueAns>{};
      public List<WrapperQueAns> propLstQuesAns { get { return lstQueAns; } set { lstQueAns = value; } }
    
    
    public void  addlstQueAns(){
    	WrapperQueAns obj = new WrapperQueAns();
    	
    	obj.ival = lstQueAns.size(); 
    	lstQueAns.add(obj);
    	 
    }
    
     public class WrapperQueAns{
                    public String title   { get; set; }
                    public string phone {get;set;}
     				public integer ival{get;set;}
     				public Shipment_Request_Detail__c spdate{
     				get{
     					spdate.Ship_From__c = system.today();
     					return spdate;
     				}set;}
     }//End Class WrapperQueAns
     
     
    public integer iget{get;set;} 
    public void deleteContact()
    {
    //	list<WrapperQueAns> lst
    	system.debug('iget'+iget);
       if(lstQueAns.size() > 0)
         	lstQueAns.remove(iget);
         	
         	for(WrapperQueAns oWrap : lstQueAns){
         		if(owrap.ival > iget){
         			
         		}
         	}
        
    }
     
     public list<Shipment_Request_Detail__c> lstspd = new list<Shipment_Request_Detail__c>();
     public void fillspd(){
     		Shipment_Request_Detail__c obj = new Shipment_Request_Detail__c();
     		lstspd.add(obj);
     }
 	public list<Shipment_Request_Detail__c> getDetails(){
 		return lstspd;
 	}  
}