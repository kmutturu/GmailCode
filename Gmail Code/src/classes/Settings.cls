public class Settings {

  //Settings variables
  public String URL {get; set;}
  public string SettingID{get; set;}
  
  public string defaultstatus{get;set;}
  
  //Constructor
  public Settings() {
    
    //Return list of settings
    list<Blog_Post__c> settings = [select ID,Post__c from Blog_Post__c limit 1];
    
    //Check for existing settings record
    if (!settings.isempty()) {
      //If one exists, loop through and assign settings variables
      for (Blog_Post__c a : settings) {
        SettingID = a.ID;
        URL = a.Post__c;
      }
    }
  }
  
  //Save settings
  public void save() {

    //Check for existing settings record indicated by presence of SettingID
    if (SettingID == null || SettingID == '') {
      //Create a new record
      Blog_Post__c newSettings = new Blog_Post__c(name =defaultstatus, Post__c = URL);
        
        try {
            Insert newSettings;
        } catch (DMLException e) {
            newSettings.addError('There was a problem adding the settings. The error message returned is: ' + e.getMessage());
        }
    } else {
      //Update the existing settings record
      Blog_Post__c  updateSettings = new Blog_Post__c(Post__c = URL);
        
        try {
            update updateSettings;
        } catch (DMLException e) {
            updateSettings.addError('There was a problem updating the settings. The error message returned is: ' + e.getMessage());
        }
    }
  }
}