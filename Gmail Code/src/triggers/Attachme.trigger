trigger Attachme on Attachment (after insert, after update, before delete) {
	
	List<AttachmentHistory__c> lstHistoryToBeIns = new List<AttachmentHistory__c>();
  
    if(trigger.isBefore && trigger.isDelete)
    {
      
        for(Attachment objAttach : trigger.old)
        {
            AttachmentHistory__c objHistory = new AttachmentHistory__c();
            system.debug('*****Printing Old Attachment Body data'+objAttach.body);
            objHistory.Body__c = Encodingutil.base64Encode(objAttach.body);
           
            lstHistoryToBeIns.add(objHistory);
         
        }
    }  
    if(trigger.isAfter)
    {
       
        for(Attachment objAttach : trigger.new)
        {
       
            AttachmentHistory__c objHistory = new AttachmentHistory__c();
            system.debug(Encodingutil.base64Encode(objAttach.Body));
           
            objHistory.Body__c = Encodingutil.base64Encode(objAttach.body);
            
            lstHistoryToBeIns.add(objHistory); 
         
        }
    }
    if(lstHistoryToBeIns!=null && lstHistoryToBeIns.size()>0)
    {
        Database.SaveResult[] lsr = Database.insert(lstHistoryToBeIns);
    }  

}