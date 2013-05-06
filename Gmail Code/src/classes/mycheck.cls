public class mycheck{
    
    list<mycheckwrapper>  lstmycheckwrapper = new list<mycheckwrapper>();
    
     public list<mycheckwrapper> getActs(){
        
        if(lstmycheckwrapper.size() == 0){
            for(integer i = 0;i<5;i++){
                mycheckwrapper obj = new mycheckwrapper();
                 lstmycheckwrapper .add(obj);
             }
         }
         return lstmycheckwrapper;  
     }
     
     
     
     public pagereference save(){
     
         system.debug('************'+lstmycheckwrapper); 
         return null;
     }
}