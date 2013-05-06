public with sharing class Communication{

  
	public string strVal{
		get{
				
			return 'My Value From the Class';
		}
		set{}
	}
	
	//public string[] strId{get;set;}
	string[] strId = new list<string>();
	
	public string[] getstrId(){
		return strId;
	}
	public void setstrId(string[] value){
		strId = value;
	}
	
	
	public list<selectOption> getAccount(){
		list<selectOption> options = new list<selectOption>();
			list<account> lstAcct = [select id,name from account];
			for(Account obj : lstAcct){
				options.add(new SelectOption(obj.id,obj.name));	
			}
			return options;
	}
	public pageReference saveme(){
		system.debug('**************'+strId);
		
		for(string str :  strId){
			//if(strId != null){
				 //lstAct = new list<account>();
				system.debug(str);
				list<account> lstAct = [select id from account where id = :str];
				lstAct[0].site = 'www.salesforce.com';
				system.debug(lstAct[0]);
				insert lstAct;
			//}
		}
		//pageReference pg = new pageReference('https://ap1.salesforce.com/'+strId);
		//pg.setRedirect(true);*/
		return null;
	}
	

}