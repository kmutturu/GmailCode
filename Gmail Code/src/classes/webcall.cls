global class webcall{
/*string strVal= 'kiran';
 public void setstrVal(string value){
    strVal = value; 
 }  
 
 public string getstrVal(){
     return strVal;
 }*/ 
 public string strVal{get{return 'kiran';}set{}}
 
 public static list<account> getAcct(){
     list<account> lst = [select id,name from account];
     return lst;
 }
 
 
 webservice static void chage(){
  string strId ='001900000053k4K';
     if(strId != null && strId != ''){
         list<account> lst = new list<account>();
         lst = [select id,name from account where id = :strId];
         if(lst.size() > 0)
         lst[0].name = 'testname';
         update lst;
         
     }
 }
}