public class hashurl{


        public hashurl(){
            strval = 'first';
             string str = url.getCurrentRequestUrl().toExternalForm(); 
        system.debug('********'+str);
        }

     public string strval{get;set;}
    
    
    public pagereference method1(){
        string str = url.getCurrentRequestUrl().getref(); 
        system.debug('********'+str);
        a= true;
        return null;
    }
    

    boolean a = false;
    
    public void seta(boolean value){
        a = value;
    }
    
    public boolean geta(){
        return a;
    }


}