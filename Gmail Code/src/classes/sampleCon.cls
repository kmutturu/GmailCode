public class sampleCon {
    String country = null;
   
  
                
    public List<SelectOption> getItems() {
        List<SelectOption> options = new List<SelectOption>(); 
        options.add(new SelectOption('Hardware','Hardware')); 
        options.add(new SelectOption('SoftWare','SoftWare')); 
         return options; 
    }
                   
    public String getCountry() {
        return country;
    }
                    
    public void setCountry(String country) { this.country = country; }
    
    
}