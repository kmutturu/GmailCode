public class SampleController {
   private User user {get; set;}
    
   public SampleController () {
      String userid = UserInfo.getUserId();
      user = [select testfield__c from User where id = :userid];
   }    
   
   public PageReference login() {
      try {
         String testfield = user.testfield__c;
         if(testfield != null && testfield.length() > 0) {
           system.debug('&&&&');
         }
         else {
            Exception e;
            throw new GsException();
         }
      }
      catch (Exception e) {
         String summary = e.getMessage();
         ApexPages.addMessage(new ApexPages.Message(ApexPages.severity.ERROR, summary)); 
      }
      return null;
   }
}