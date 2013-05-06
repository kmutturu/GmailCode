global class testglobal{

    webservice static void mymethod(string strname){
        list<contact> lstCon = [select id from contact where lastname = :strname];
        
        lstcon[0].phone = '814874343';
        update lstcon;
            
    }
    
   
    
}