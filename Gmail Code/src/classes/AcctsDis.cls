public class AcctsDis{


    public acctsdis(){
    
        system.debug(apexpages.currentpage().getheaders());
    
    }

 
 public void mydetails(){



    for(integer i =0;i<150;i++){
    
        list<account> lstAccount = [select id from account limit 5];
    }
    
 
 }
  

  
  
  
  
  
  
}