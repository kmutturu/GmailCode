public class DataTableExampleController {
    
    public ApexPages.StandardSetController contactSet {
        
        get {
            if(contactSet == null) {
                contactSet = new         
                ApexPages.StandardSetController(Database.getQueryLocator(
                [SELECT Name, Phone, Email, Title, Account.Name FROM Contact]));
            }
            return contactSet;
        }
        set;
    }
    public List<contact> getContacts() {
         return (List<contact>) contactSet.getRecords();
    }
}