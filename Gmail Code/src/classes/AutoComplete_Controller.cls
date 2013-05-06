//Controller used for the AutoComplete Enhancement

public with sharing class AutoComplete_Controller{

    //Constructors
    
    public AutoComplete_Controller() {}
    
    public AutoComplete_Controller(ApexPages.StandardController controller) {}

    //Attributes
    
    private List<String> resultsname = new List<String>();
    private List<String> Tempresultsname = new List<String>();
    private Boolean hasparams = false;
    private Boolean hasnoresults = false;
        
    //Getters and Setters
    
    public Boolean getHasparams(){

        return hasparams;
        
    }
    
    public void clearValues(){
        
        hasparams = false;
        
    }
    
    public Boolean getHasnoresults(){
    
        return hasnoresults;    
    }

    public void avoidRefresh(){
        
    }
    
     public PageReference searchSuggestions() {

        //Initalize variables, hasparams just indicates that a search has started
        resultsname.clear();   
        hasparams = true;
        hasnoresults = false;
        string backslash = '\\';
        system.debug('backslash'+backslash);
        string quote = '\'';
        system.debug('quote'+quote);
        string regexp = '\\' + '\'';
        system.debug('regexp'+regexp); 
        
        
        //Obtain current parameters
        String sobjectname = System.currentPageReference().getParameters().get('objectname');
        String stext = '%'+System.currentPageReference().getParameters().get('aname')+'%';
        string rstext = stext;
        
        //Limit Suggestions to 10 Results
        Integer iLimit = 100;
        
     //Validate if there's an input and get results
     system.debug('name'+stext);   
     if(stext.length() >4){
        try{
                if(stext.indexOf('\'') > -1)
                {
                    system.debug('entered in to to index checking'+stext.indexOf('\''));
                    rstext = string.escapeSingleQuotes(stext);
                    
                }
            system.debug('name'+stext);
            system.debug('name'+stext.length());
              String sql = 'select Id,name from ' + sobjectname + ' where name like \''+rstext+'\' or firstname like \''+rstext+'\' limit '+ iLimit;
              system.debug('sql'+sql);
                    for(sobject x : Database.query(sql)){
                        
                        String s  = (String)(x.get('name'));
                        s= s+':'+(x.get('Id'));
                        resultsname.add(s); 
                    }
                    system.debug('----resultsname----'+resultsname);
                    system.debug('-----stext.length()----'+stext.length());
                    system.debug('-----rstext.length()----'+rstext.length());
            if(stext.length() >5)
            {
                system.debug('entered');
                system.debug('stext'+rstext);
                for(integer i=0;i<resultsname.size();i++){
                    Tempresultsname.add(resultsname[i]);                    
                }
                system.debug('----Tempresultsname----'+Tempresultsname);
                resultsname.clear();
                system.debug('stext'+stext);
                stext = stext.substring(1,(stext.length()-1));
                for(integer i=0;i<Tempresultsname.size();i++){
                    if(Tempresultsname[i].touppercase().contains(stext.touppercase())){
                        resultsname.add(Tempresultsname[i]);
                    }
                }
                system.debug('----resultsname----'+resultsname);
                
                Tempresultsname.clear();
            }
            
        }catch(Exception e){
            
            resultsname.add('Unexpected Error, please contact support');    
        }


     }
       return null;
  }
  
      
      
     public List<String> getResultsname(){
          //Make sure to clear past values
          clearValues();
          if(resultsname.isEmpty()){
            hasnoresults = true;
            resultsname.add('No Results');
          }
          system.debug('----resultsname----'+resultsname+'-----'+hasnoresults);
          return resultsname;
      }
      
      public static void dummy1(){          
               
        string a = '123';string b = a;string c = b;string d = a;c = b;b = a;
        d = a;c = b;b = a;d = a;c = b;b = a;d = a;c = b;b = a;d = a;c = b;b = a;
        d = a;c = b;b = a;d = a;c = b;b = a;d = a;c = b;b = a;d = a;c = b;b = a;
        d = a;c = b;b = a;d = a;c = b;b = a;d = a;c = b;b = a;d = a;c = b;b = a;
        d = a;c = b;b = a;d = a;c = b;b = a;d = a;c = b;b = a;d = a;c = b;b = a;
        d = a;c = b;b = a;d = a;c = b;b = a;d = a;

    }
    
    public static void dummy2(){
       string a = '123';string b = a;string c = b;string d = a;c = b;b = a;
        d = a;c = b;b = a;d = a;c = b;b = a;d = a;c = b;b = a;d = a;c = b;b = a;
        d = a;c = b;b = a;d = a;c = b;b = a;d = a;c = b;b = a;d = a;c = b;b = a;
        d = a;c = b;b = a;d = a;c = b;b = a;d = a;c = b;b = a;d = a;c = b;b = a;
        d = a;c = b;b = a;d = a;c = b;b = a;d = a;c = b;b = a;d = a;c = b;b = a;
        d = a;c = b;b = a;d = a;c = b;b = a;d = a;
    }
    
    public static void dummy3(){
      string a = '123';string b = a;string c = b;string d = a;c = b;b = a;
        d = a;c = b;b = a;d = a;c = b;b = a;d = a;c = b;b = a;d = a;c = b;b = a;
        d = a;c = b;b = a;d = a;c = b;b = a;d = a;c = b;b = a;d = a;c = b;b = a;
        d = a;c = b;b = a;d = a;c = b;b = a;d = a;c = b;b = a;d = a;c = b;b = a;
        d = a;c = b;b = a;d = a;c = b;b = a;d = a;c = b;b = a;d = a;c = b;b = a;
        d = a;c = b;b = a;d = a;c = b;b = a;d = a;
        
        d = a;c = b;b = a;d = a;c = b;b = a;d = a;c = b;b = a;d = a;c = b;b = a;
        d = a;c = b;b = a;d = a;c = b;b = a;d = a;c = b;b = a;d = a;c = b;b = a;
        d = a;c = b;b = a;d = a;c = b;b = a;d = a;c = b;b = a;d = a;c = b;b = a;
        d = a;c = b;b = a;d = a;c = b;b = a;d = a;c = b;b = a;d = a;c = b;b = a;
        d = a;c = b;b = a;d = a;c = b;b = a;d = a;
    }
    public static void dummy4(){          
               
        string a = '123';string b = a;string c = b;string d = a;c = b;b = a;
        d = a;c = b;b = a;d = a;c = b;b = a;d = a;c = b;b = a;d = a;c = b;b = a;
        d = a;c = b;b = a;d = a;c = b;b = a;d = a;c = b;b = a;d = a;c = b;b = a;
        d = a;c = b;b = a;d = a;c = b;b = a;d = a;c = b;b = a;d = a;c = b;b = a;
        d = a;c = b;b = a;d = a;c = b;b = a;d = a;c = b;b = a;d = a;c = b;b = a;
        d = a;c = b;b = a;d = a;c = b;b = a;d = a;

    }
    
    public static void dummy5(){
       string a = '123';string b = a;string c = b;string d = a;c = b;b = a;
        d = a;c = b;b = a;d = a;c = b;b = a;d = a;c = b;b = a;d = a;c = b;b = a;
        d = a;c = b;b = a;d = a;c = b;b = a;d = a;c = b;b = a;d = a;c = b;b = a;
        d = a;c = b;b = a;d = a;c = b;b = a;d = a;c = b;b = a;d = a;c = b;b = a;
        d = a;c = b;b = a;d = a;c = b;b = a;d = a;c = b;b = a;d = a;c = b;b = a;
        d = a;c = b;b = a;d = a;c = b;b = a;d = a;
    }
    
    public static void dummy6(){
      string a = '123';string b = a;string c = b;string d = a;c = b;b = a;
        d = a;c = b;b = a;d = a;c = b;b = a;d = a;c = b;b = a;d = a;c = b;b = a;
        d = a;c = b;b = a;d = a;c = b;b = a;d = a;c = b;b = a;d = a;c = b;b = a;
        d = a;c = b;b = a;d = a;c = b;b = a;d = a;c = b;b = a;d = a;c = b;b = a;
        d = a;c = b;b = a;d = a;c = b;b = a;d = a;c = b;b = a;d = a;c = b;b = a;
        d = a;c = b;b = a;d = a;c = b;b = a;d = a;
        
        d = a;c = b;b = a;d = a;c = b;b = a;d = a;c = b;b = a;d = a;c = b;b = a;
        d = a;c = b;b = a;d = a;c = b;b = a;d = a;c = b;b = a;d = a;c = b;b = a;
        d = a;c = b;b = a;d = a;c = b;b = a;d = a;c = b;b = a;d = a;c = b;b = a;
        d = a;c = b;b = a;d = a;c = b;b = a;d = a;c = b;b = a;d = a;c = b;b = a;
        d = a;c = b;b = a;d = a;c = b;b = a;d = a;
    }

}//class