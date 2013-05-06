public class actionclass{

    string strId = '';
    
    public actionclass(ApexPages.StandardController controller) {
    
        strId = ApexPages.currentpage().getParameters().get('Id');   
        system.debug(strId);

    }
        
    
    public pagereference save(){
        
        return null;
    }
}