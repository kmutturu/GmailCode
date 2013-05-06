@isTest
private class TestGlobalClassEmail {

    public static final String Account= 'Account of Test Email';
     public static final String Production= 'Production of Test Email';
     public static final String Owner_FirstName = 'Owner_FirstName of Test Email';
     public static final String Owner_LastName = 'Owner_LastName of Test Email';
     public static final String Go_Live_Date = 'Go_Live_Date of Test Email';
     public static final String Product = 'Product of Test Email';
     public static final String FUSION_Tools_User  = 'FUSION_Tools_User of Test Email';
     public static final String FUSION_Tools_Pass = 'FUSION_Tools_Pass of Test Email';
     public static final String CallSource_User = 'CallSource_User of Test Email'; 
     public static final String CallSource_Pass = 'CallSource_Pass of Test Email';
     public static final String GA_User = 'GA_User of Test Email';
     public static final String GA_Pass = 'GA_Pass of Test Email';
     public static final String Production_Link = 'Production_Link of Test Email'; 

    static testMethod void myUnitTest() {
      
     
     ReadyForTraining.SendEmailNotification(Account,  Production,  Owner_FirstName,  Owner_LastName,  Go_Live_Date,  Product, FUSION_Tools_User, FUSION_Tools_Pass, CallSource_User, CallSource_Pass, GA_User, GA_Pass, Production_Link);   
     
    }
}