public class guideddata{
public ID id;
public GE_PW_User_Sales_Hierarchy_Association__c g;
public ID urluser{get;set;}
public User manager{get;set;}
public user mgr{get;set;}
public user usr{get;set;}
public string own{get;set;}
public List<SelectOption> locationlist{get;set;}
public string loc{get;set;}
public List<selectoption> sel{get;set;}
public string flag;
public Boolean shouldRender{get;set;}
public list<GE_PW_User_Sales_Hierarchy_Association__c> Managerlocationid = new List<GE_PW_User_Sales_Hierarchy_Association__c>();
public list<GE_PW_User_Sales_Hierarchy_Association__c> Userlocationid = new List<GE_PW_User_Sales_Hierarchy_Association__c>();
public list<GE_PW_User_Sales_Hierarchy_Association__c> loclist= new list<GE_PW_User_Sales_Hierarchy_Association__c>();
public GE_PW_User_Sales_Hierarchy_Association__c sec = new GE_PW_User_Sales_Hierarchy_Association__c();
public GE_PW_User_Sales_Hierarchy_Association__c assignuser = new GE_PW_User_Sales_Hierarchy_Association__c();
public GE_PW_User_Sales_Hierarchy_Association__c pcklst = new GE_PW_User_Sales_Hierarchy_Association__c();
public list<GE_PW_User_Sales_Hierarchy_Association__c> lst = new list<GE_PW_User_Sales_Hierarchy_Association__c>();
public GE_PW_User_Sales_Hierarchy_Association__c Parentleveltype = new GE_PW_User_Sales_Hierarchy_Association__c();
public GE_PW_User_Sales_Hierarchy_Association__c fields = new GE_PW_User_Sales_Hierarchy_Association__c();
public list<GE_PW_User_Sales_Hierarchy_Association__c> locid = new list<GE_PW_User_Sales_Hierarchy_Association__c>();
public list<GE_PW_User_Sales_Hierarchy_Association__c> seclocationid = new list<GE_PW_User_Sales_Hierarchy_Association__c>();
 
public id locsfid;
public guideddata(ApexPages.StandardController controller)
{
id=System.currentPageReference().getParameters().get('userid');
manager=[select managerid from user where id=:id];
if(manager.managerId!=null)
{
mgr=[Select Name from User where id=:manager.managerId];
String s=mgr.Name;
}
usr=[select name from User where id=:id];
string l=usr.name;
locsfid=System.currentPageReference().getParameters().get('locsfid');
//Parentleveltype=[select GE_PW_Location_Level_Name__c from GE_PW_User_Sales_Hierarchy_Association__c where GE_PW_User_ID__c=:manager.managerid and GE_PW_Primary_OwnerShip_Flag__c= 'YES' limit 1];
Managerlocationid=[Select GE_PW_Location_ID__c from GE_PW_User_Sales_Hierarchy_Association__c where GE_PW_User_ID__c=:manager.managerid and GE_PW_Primary_OwnerShip_Flag__c= 'YES'];
Userlocationid=[select id,GE_PW_Location_ID__c from GE_PW_User_Sales_Hierarchy_Association__c where GE_PW_User_ID__c=:id and GE_PW_Primary_OwnerShip_Flag__c= 'YES'];
locationlist = new List<SelectOption>();
for(GE_PW_User_Sales_Hierarchy_Association__c m:Managerlocationid)
{
loclist.add(m);
}
for(GE_PW_User_Sales_Hierarchy_Association__c u:Userlocationid)
{
loclist.add(u);
}
for(GE_PW_User_Sales_Hierarchy_Association__c h:loclist)
{
if(h.GE_PW_Location_ID__c!=null)
{
locationlist.add(new selectoption(h.id,h.GE_PW_Location_ID__c));
}
}
sel=new List<SelectOption>();
sel.add(new SelectOption('', '--None--'));
sel.add(new SelectOption('Ownership', 'Ownership'));
sel.add(new SelectOption('Visibility', 'Visibility'));

this.g = (GE_PW_User_Sales_Hierarchy_Association__c)controller.getRecord();
this.g.GE_PW_Location_Level_Name__c = ApexPages.currentpage().getParameters().get('SapIDType');
this.g.GE_PW_Location_ID__c = ApexPages.currentpage().getParameters().get('SapID');
loc= ApexPages.currentpage().getParameters().get('owner');
}
public void doDisable() {
  if (loc == 'Visibility') {
    shouldRender = false;
  } else if(loc == 'Ownership'){
    shouldRender = true;
  }
}
public PageReference back()
{
PageReference NewPage=new PageReference('/apex/ManageLocationid?id='+id);
 NewPage.setRedirect(true);
   return NewPage;
}     
 
public PageReference save()
{
lst=[select GE_PW_Parent_Location_ID__c from GE_PW_User_Sales_Hierarchy_Association__c where GE_PW_User_ID__c=:id and GE_PW_Primary_OwnerShip_Flag__c='YES' limit 1];
locid=[select id from GE_PW_User_Sales_Hierarchy_Association__c where GE_PW_Location_ID__c=:g.GE_PW_Location_ID__c and GE_PW_Primary_Ownership_Flag__c='YES'];
if(locid.size()>0)
{
fields=[select GE_PW_Parent_Location_ID__c,GE_PW_Parent_Location_Level_Name__c from GE_PW_User_Sales_Hierarchy_Association__c where id=:locid limit 1];
}
if(shouldRender==true && own!=null)
{
pcklst=[select GE_PW_Location_ID__c,GE_PW_Location_Level_Name__c from GE_PW_User_Sales_Hierarchy_Association__c where id=:own];
}
if(loc=='Ownership')
{
flag='YES';
}
else if(loc=='Visibility')
{
flag='NO';
}
if(g.GE_PW_Location_Level_Name__c!=null && g.GE_PW_Location_ID__c!=null && loc!=null )
 
{
if(locsfid!=null)
{
sec=[select GE_PW_Location_Level_Name__c,GE_PW_Location_ID__c,GE_PW_Primary_OwnerShip_Flag__c,GE_PW_Parent_Location_ID__c,GE_PW_Parent_Location_Level_Name__c from GE_PW_User_Sales_Hierarchy_Association__c where id=:locsfid ];
sec.GE_PW_Location_Level_Name__c = g.GE_PW_Location_Level_Name__c;
sec.GE_PW_Location_ID__c = g.GE_PW_Location_ID__c;
sec.GE_PW_Primary_OwnerShip_Flag__c = flag;
system.debug('len:'+shouldRender);
if(shouldRender==true && own!=null)
{
sec.GE_PW_Parent_Location_ID__c = pcklst.GE_PW_Location_ID__c;
sec.GE_PW_Parent_Location_Level_Name__c=pcklst.GE_PW_Location_Level_Name__c;
}
else if(shouldRender==false)
{system.debug('inside');
//sec.GE_PW_Parent_Location_ID__c = lst[0].GE_PW_Parent_Location_ID__c;
//system.debug('Parent:'+lst[0].GE_PW_Parent_Location_ID__c  );
//sec.GE_PW_Parent_Location_Level_Name__c=Parentleveltype.GE_PW_Location_Level_Name__c;
if(locid.size()>0)
{
sec.GE_PW_Parent_Location_ID__c = fields.GE_PW_Parent_Location_ID__c;
sec.GE_PW_Parent_Location_Level_Name__c=fields.GE_PW_Parent_Location_Level_Name__c;
}
else
{
sec.GE_PW_Parent_Location_ID__c = 'NO';
sec.GE_PW_Parent_Location_Level_Name__c='NO';
}

}
update sec;
}
else
{
assignuser.GE_PW_Location_Level_Name__c= g.GE_PW_Location_Level_Name__c;
assignuser.GE_PW_Location_ID__c = g.GE_PW_Location_ID__c;
assignuser.GE_PW_Primary_OwnerShip_Flag__c = flag;
assignuser.GE_PW_User_ID__c=id;
if(shouldRender==true && own!=null)
{
assignuser.GE_PW_Parent_Location_ID__c=pcklst.GE_PW_Location_ID__c;
assignuser.GE_PW_Parent_Location_Level_Name__c=pcklst.GE_PW_Location_Level_Name__c;
}
else if(shouldRender==false)
{
//assignuser.GE_PW_Parent_Location_ID__c=lst[0].GE_PW_Parent_Location_ID__c;
//assignuser.GE_PW_Parent_Location_Level_Name__c=Parentleveltype.GE_PW_Location_Level_Name__c;
if(locid.size()>0)
{
assignuser.GE_PW_Parent_Location_ID__c=fields.GE_PW_Parent_Location_ID__c;
assignuser.GE_PW_Parent_Location_Level_Name__c=fields.GE_PW_Parent_Location_Level_Name__c;
}
else
{
assignuser.GE_PW_Parent_Location_ID__c='NO';
assignuser.GE_PW_Parent_Location_Level_Name__c='NO';
}
}
insert assignuser;
}
}
else
{
ApexPages.addMessage(new ApexPages.message(ApexPages.severity.ERROR,'Please enter values for all fields.'));
            return null;
}
PageReference NewPage=new PageReference('/apex/ManageLocationid?id='+id);
NewPage.setRedirect(true);
return Newpage;
 
}
}