public class ClassUsingSOQL {
	decimal d = 0.0;
	public decimal getListOfAccounts(){
		
		for(Account objAccount : [select id,name,AnnualRevenue from account]){
			if(objAccount.AnnualRevenue != null)
			 	d += objAccount.AnnualRevenue;		
		}
		
		return d;
	}
	
	

}