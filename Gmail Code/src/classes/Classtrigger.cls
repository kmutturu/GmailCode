public with sharing class Classtrigger {

public string getVal(string strID){
		if(strID != null){
			list<account> lst = [select id,fax from account where id = :strID];
			if(lst.size() > 0 && lst[0].fax == null)
				return 'please fll the accounts fax number before';
		}	
	return null;
}

}