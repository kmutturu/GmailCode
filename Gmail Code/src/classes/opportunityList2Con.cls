public class opportunityList2Con {
  // ApexPages.StandardSetController must be instantiated  
    
  // for standard list controllers  
   // ApexPages.StandardSetController objsetCon = new ApexPages.StandardSetController();
    integer ipagenum = 0;
    public ApexPages.StandardSetController setCon {
        get {
            if(setCon == null) {
                setCon = new ApexPages.StandardSetController(Database.getQueryLocator(
                      [select name,closedate from Opportunity]));
                ipagenum = setCon.getPageNumber();
                system.debug('************'+ipagenum);
            }
            return setCon;
        }
        set;
    }

    // Initialize setCon and return a list of records  
    
    public List<Opportunity> getOpportunities() {
         return (List<Opportunity>) setCon.getRecords();
    }
    public void next(){
      ipagenum = setCon.getPageNumber();
        system.debug('************'+ipagenum);
        setCon.next();     
    }
  }