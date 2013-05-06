public class searchAccount {
  private List<Account> accounts;
  public List<Account> getAccounts() { return accounts; }
  public searchAccount() { // constructor
    String q = System.currentPageReference().getParameters().get('q');
    if (q != null) {
      String fuzzy = '%' + q + '%'; // add wild cards
      accounts = [select id,name,phone from Account where name like :fuzzy ];
    }
  }

}