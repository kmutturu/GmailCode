public class PaginationController {

    private final Account acct;
    private List<Account> accts;
    private String query;
    private String paginationClause;
    public integer queryLimit {get; set;}
    public integer queryOffset {get; set;}    
    public String direction {get; set;}
    public boolean disableNextPage {get; set;}
    public boolean disablePrevPage {get; set;}
        
    public PaginationController() {
        // initialize default values
        this.queryLimit = 5;
        this.queryOffset = 0;
        this.direction = 'ASC ';
        this.query = 'SELECT Id, Name, Industry, AnnualRevenue, Website FROM Account ';
        getPage();        
        checkButtons();
    }
        
    public List<Account> getNextPage(){
        this.queryOffset = queryOffset + queryLimit;
        if (queryOffset <0) queryOffset = 0;
        refreshQuery ();
        getPage();
        checkButtons();
        return accts;
    }

    public List<Account> getPreviousPage(){
        this.queryOffset = queryOffset - queryLimit;
        if (queryOffset <0)queryOffset = 0;
        refreshQuery();
        getPage();
        checkButtons();
        return accts;
    }

    public List<Account> getFirstPage(){
        this.queryOffset = 0;
        this.direction = 'ASC ';
        refreshQuery ();
        getPage();
        checkButtons();
           
        return accts;
    }
    
    public List<Account> getLastPage(){
        this.queryOffset = 0;
        this.direction = 'DESC ';
        refreshQuery ();
        getPage();
        checkButtons();
           
        return accts;
    }
    
    public List<Account> getPage(){
        refreshQuery ();
        this.accts = Database.query(query + paginationClause);
                
        return accts;
    }
    
    public List<SelectOption> getDirections() {
        List<SelectOption> options = new List<SelectOption>();
        options.add(new SelectOption('ASC ','ASC'));
        options.add(new SelectOption('DESC ','DESC'));
        return options;
    }
    
    public String getQuery(){
        return this.query + paginationClause;
    }
        
    public PageReference runQuery() {
        getPage();
        return null;
    }

    public PageReference runPrevQuery() {
        getPreviousPage();
        return null;
    }

    public PageReference runNextQuery() {
        getNextPage();
        return null;
    }
    
    public PageReference runFirstQuery() {
        getFirstPage();
        return null;
    }

    public PageReference runLastQuery() {
        getLastPage();
        return null;
    }

    private void refreshQuery () {
        this.paginationClause = 'ORDER BY Name ';
        this.paginationClause += direction;
        this.paginationClause += 'LIMIT ' + queryLimit + ' OFFSET ' + queryOffset;
    }
    
    private void checkButtons() {
        nextPageCheck();
        prevPageCheck();           
    }
    
    private void nextPageCheck() {
        if (accts.size() == queryLimit){ 
            disableNextPage = false;       
        } else {
            disableNextPage = true;
        }
    }
    
    private void prevPageCheck() {
        if (queryOffset == 0) {
            disablePrevPage = true;
        } else {
            disablePrevPage = false;
        }
    }

}