public with sharing class dynamiccomp {

    string act = '';

 public void setact(string val){
     system.debug('*****'+val);
     act = val;
     
 }
  
  public string getact(){
   system.debug('*****'+act);
      return act;
  }


    public Component.Apex.detail getMyFieldSetSection()
    {
        system.debug('before method'+act);
        
        if(act != null && act != ''){
            system.debug('enbetere');
            
            String fullFileURL = URL.getSalesforceBaseUrl().toExternalForm() + '/' + act;
             Component.Apex.detail rTag = new Component.Apex.detail();
            rTag.subject = act;
             return rTag;
         }
         return null;
    }

}