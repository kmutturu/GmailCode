public with sharing class classba {
public String accName { get; set; }
List<Account> lstaccount = new List<Account>();
List<contact> lstcontacts = new List<contact>();
set<string> accIds = new set<string>();
public List<contact> getConRecords() {
lstcontacts.clear();
accIds.clear();
lstaccount.clear();
system.debug('****AccNameTextValue is *****'+accName);
lstaccount=[select id,name,phone from Account where name=:accName];
for(Integer i=0;i<lstaccount.size();i++)
{
accIds.add(lstaccount[i].Id);
}
lstcontacts =[select id,name,phone from contact where accountid in : accIds];
system.debug('**** List of Contacts for Test is ***'+lstcontacts);
return lstcontacts;
}
public pagereference showContacts() {
return null;

}
}