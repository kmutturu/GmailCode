public class exampleCon {                  
    public String JSONSearchAccounts{ get; set; }
   
    public PageReference SearchAccounts() {
        String searchTerm = Apexpages.currentPage().getParameters().get('searchTerm');         
        String soql = 'SELECT Id, Name FROM Account WHERE Name like \'' + searchTerm + '%\'';              
        List<Account> accountList = Database.query(soql);          
       
        string json = '[';
        for(Account acct : accountList){
            json += '{"id": "' + acct.Id + '", ' +
            '"name": "' + acct.Name + '"},';
        }
        json += ']';
        json = json.replace('},]', '}]');
       
        JSONSearchAccounts = json.replace('\'', '');
        return null;
    }
   
    public String JSONAccountDetails{ get; set;}
       
    public PageReference GetAccountDetails() {
        String accountid = Apexpages.currentPage().getParameters().get('accountid');           
        String soql = 'SELECT Id, Name, Type, AccountNumber, Description, Website FROM Account WHERE Id=\'' + accountid + '\'';            
        List<Account> accountList = Database.query(soql);
       
        if(accountList.size() != 1){
            JSONAccountDetails = '{"error": "Expected only 1 account"}';
            return null;
        }          
       
        string json = '{';     
        json += '"id": "' + accountList[0].Id + '", ';     
        json += '"name": "' + accountList[0].Name + '", ';
        json += '"type": "' + accountList[0].Type + '", ';
        json += '"accountNumber": "' + accountList[0].AccountNumber + '", ';
        json += '"description": "' + accountList[0].Description + '", ';
        json += '"website": "' + accountList[0].Website + '" ';
        json += '}';       
       
        JSONAccountDetails = json.replace('\'', '');
        return null;
    }
}