public class blogController {

public PageReference handleNewPostClick() {
 PageReference pageRef= new PageReference('/apex/blogedit');
 pageRef.setredirect(true);
 return pageRef;
}

public Blog_Post__c[] getPosts() {
 return [select Name, id, CreatedDate, CreatedBy.Name, Post__c from Blog_Post__c];
 }
}