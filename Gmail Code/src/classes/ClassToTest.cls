public with sharing class ClassToTest {

    public ClassToTest(ApexPages.StandardController controller) {

    }

	
	public string strVal{
		
		get{
			return 'My First Value From the Class';
		}
		set{
			
		}
	}
	
	public list<account> getAccts(){
		list<account> lstact = new list<account>();
		lstact = [select id,name from account order by name asc];
		if(lstact.size() > 0)
			return lstact;
		return null;
	}

}