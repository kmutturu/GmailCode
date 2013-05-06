public class actionpoll{

    public String all { get; set; }
    
    public string SelText{set;get;}
    list<selectoption> options = new list<selectoption>();
    string selected = '';
    
    public void setselected(string val){
        selected = val;
    }
    
    public string getselected(){
        //system.debug('accept---'+selected);
        system.debug('----select----'+selected);
        SelText='';
       
            SelText += selected;
               return SelText;
    }
    
    public list<selectoption> getvalues(){
        options.add(new SelectOption('','--Select One--'));
                   
            for(account act : [select id,name from account limit 5]){
                options.add(new selectoption(act.name,act.name));
            }            
        
        
        return options;
    }
    public void all(){
        //setselected(selected);
      system.debug('selected'+selected);  
        //return null;
    }
    
}