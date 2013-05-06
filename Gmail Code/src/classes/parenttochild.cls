public with sharing class parenttochild {

   public parenttochild(){}
   
   public string strname{get;set;}

public pagereference save(){

Account obj = new account();

obj.name = strname;

insert obj;

pagereference pg = new pagereference('/003/e?retURL='+obj.Id+'&accid='+obj.Id);



return new PageReference('javascript&colon;window.close()');

}


}