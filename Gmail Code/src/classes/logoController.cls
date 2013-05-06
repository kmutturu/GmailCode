public class logoController { 

public string imageUrl;


public String getLogo() {
    
    // Check if User has been assigned to a Contact.
    Contact[] contactId = [SELECT id FROM Contact
    WHERE Contact.ownerid =:UserInfo.getUserId() LIMIT 1];
    
    if (ContactId.size() > 0) {
        
        // Check if Contact has been assigned a Workplace.
        string userWorkplace = [SELECT account.name FROM Contact
        WHERE Contact.ownerid = :UserInfo.getUserId() LIMIT 1].account.name;
        
        if(userWorkplace != null){
            imageUrl = [SELECT id FROM Contact
            WHERE Contact.ownerid = :UserInfo.getUserId() limit 1].id;
            
            // Check if Workplace logo URL has been uploaded.
            if(imageUrl == null){
            imageUrl= 'https://someimage';
                        }
            
            }else {
                imageUrl= 'https://someimage';
                }
        
        }else{
            
            imageUrl= 'https://someimage';
            }
            
            return imageUrl;
            }
}