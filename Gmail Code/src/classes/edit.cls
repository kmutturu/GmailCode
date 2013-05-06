public with sharing class edit
{
list<account>emp=new list<account>();
account empobj;

public string eid{get;set;}
public list<account> getEmployees()
{
emp=[select id,name from account order by name limit 20];
return emp;
}
public PageReference editing()
{


pageReference editPage = new PageReference('/'+eid+'/e');
editPage.setRedirect(true);
return editPage;

}
}