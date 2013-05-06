trigger Newone on Contact (before insert)
{
//Map<id,string> m=new map<id,string>();
//map<id,string> k=new map<id,string>();
set<id>light=new set<id>();
list<contact> d=new list<contact>();
d=trigger.new;//here u assigned the tigger.new list to d
for(contact r:d)
{
d.add(r);//once again u are adding the same list to d
//m.put(c.accountid,c.email);
}
for(integer i=0;i<d.size();i++)
{
contact[]c=[select id,accountid, email from contact where email =:d[i].email];
if(c.size()>0)
{
integer a=0;
a=a+1;
account []scc=[select id,name from account where id =:d[i].accountid];
for(integer sk=0;sk<scc.size();sk++)
{
System.debug('The name of the account associated with the contact which has matching email with the inserted email'+scc[sk].name);
}
}
}
}