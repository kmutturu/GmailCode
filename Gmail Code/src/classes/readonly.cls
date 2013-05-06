public class readonly{
    public string firstval{get;set;}
    public string check{get;set;}
     
    boolean gotov = false;
    public void setgotov(boolean value){
        gotov = value;
    }
    public boolean getgotov(){
        return gotov;
    }
    public string Str{get;set;}
    
   public List<SelectOption> getStartTimes(){
        List<SelectOption> options = new List<SelectOption>();         
             options.add(new selectoption('Active flow','Active flow'));
             options.add(new selectoption('Active','Active'));
              options.add(new selectoption('Error flowZ','Error flowZ'));
               options.add(new selectoption('ReadOnly','ReadOnly'));
            return options;
    }
    
    public pagereference meVal(){
        if(Str == 'ReadOnly')
            gotov = true;
         return null;   
    }
}