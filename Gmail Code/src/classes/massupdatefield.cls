public with sharing class massupdatefield{
public List<Contact> contacts{get; set;}
public list<selectoption> options{Get; set;}
public string selected{get; set;}
String saveUrl = ApexPages.currentPage().getParameters().get('retURL');
public massupdatefield(apexpages.standardsetcontroller ssc){
    contacts = (list<contact>)ssc.getSelected();
    Schema.DescribeFieldResult FR = Contact.email.getDescribe();
    List<Schema.PicklistEntry> PL = FR.getPicklistValues();
    options = new list<selectoption>();
    for(schema.PickListEntry p:PL){
       options.add(new selectoption(p.getLabel(), p.getvalue()));
    }
 
}
public pagereference updatecontacts(){
for(Contact c:contacts){
     c.email = selected;
    }
   update contacts;
return new pagereference(saveurl);
}
}