public class MyFirstClass{

    public MyFirstClass(ApexPages.StandardController controller) {
        system.debug('this is the first class in apex');
    }
   
    public string strVal{
        get{
            return 'this is a value from class';
        }
        
    }
    
    public string enteredvalue{
        get{
            system.debug('enteredvalue'+enteredvalue);
            return enteredvalue;
        }
        set{
            enteredvalue = value;
        }
    }
    
    public boolean val{
    get;
    set{
        if(enteredvalue == 'kiran')
            val = false;
    }
    }
    
    
}