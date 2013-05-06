public with sharing class files1
{
public files1() {
s1=new aaaa__c();
s2=new aaaa__c();
s3=new aaaa__c();
s4=new aaaa__c();
s4=new aaaa__c();
s5=new aaaa__c();

}



public files1(ApexPages.StandardController controller)

{

}
public aaaa__c s1 {get; set;}
public aaaa__c s2 {get; set;}
public aaaa__c s3 {get; set;}
public aaaa__c s4 {get; set;}
public aaaa__c s5 {get; set;}

public PageReference saveall() {
insert s1;
insert s2;
insert s3;
insert s4;
insert s5;
return null;
}
}