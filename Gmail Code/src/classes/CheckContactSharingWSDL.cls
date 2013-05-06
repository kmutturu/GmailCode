global class CheckContactSharingWSDL
{
    /*static List<Contact> lstContact=new List<Contact>();
    static List<Service_Provider__c> lstSp = new List<Service_Provider__c>();
    static List<Group> lstGroup=new List<Group>();
    static List<ContactShare> lstConShare=new List<ContactShare>();
    static List<AccountShare> lstAccShare = new List<AccountShare>();
    
    
    WebService static string getContactId(string FromEmail,string OwnerId,string OpCompanyId)
    {
        Map<string,string> mConAcc = new Map<string,string>();
        List<string> lstAccountIds = new List<string>();
        system.debug('%%%%%%%%%%% FromEmail...'+FromEmail+'.... OwnerId...'+OwnerId+'.....OpcompanyId...'+OpCompanyId);
        lstContact = [select id,OwnerId,Account.Owner_sp__c,AccountId from contact where Email=:FromEmail or AssistantPhone=:FromEmail or MobilePhone=:FromEmail or Phone=:FromEmail or OtherPhone=:FromEmail];
        system.debug('%%%%%%%%%%%%%%%%%%%%%%%% Contact...:'+lstContact);
        for(Contact objContact : lstContact){
            if(objContact.ownerId == OwnerId){
                return objContact.Id;
            } 
            if(objContact.AccountId != null){
                lstAccountIds.add(objContact.AccountId);
                if(mConAcc.get(objContact.Id) == null){
                    mConAcc.put(objContact.Id,objContact.AccountId);
                }   
            }
        }
        List<CC_Related_Email__c> lstRelatedEmails = [select id,contact__c,contact__r.Id,contact__r.OwnerId,Contact__r.AccountId from CC_Related_Email__c where Email__c =:FromEmail and Contact__c != null];
        if(lstRelatedEmails.size()>0){
           for(CC_Related_Email__c objRelatedEmail : lstRelatedEmails){
            if(objRelatedEmail.Contact__r.ownerId == OwnerId){
                return objRelatedEmail.Contact__r.Id;
            } 
            if(objRelatedEmail.Contact__r.AccountId != null){
                lstAccountIds.add(objRelatedEmail.Contact__r.AccountId);
                if(mConAcc.get(objRelatedEmail.Contact__r.Id) == null){
                    mConAcc.put(objRelatedEmail.Contact__r.Id,objRelatedEmail.Contact__r.AccountId);
                }     
            }
          }
        }
        lstSp=[Select Id,Operating_Company__r.Id,user__c,user__r.UserRoleId,user__r.UserRole.ParentRoleId from Service_Provider__c where user__c =:OwnerId and operating_Company__c=:OpCompanyId];
        
        string SPUserParentRoleId = '';
        string SPUserRoleId;
        if(lstSp.size()>0){
            SPUserParentRoleId = lstSp[0].user__r.UserRole.ParentRoleId;
            SPUserRoleId = lstSp[0].user__r.UserRoleId;
        } 
        if(SPUserParentRoleId != '' && SPUserRoleId != ''){
            lstGroup=[select Id,RelatedId from Group where RelatedId=:SPUserRoleId or RelatedId=:SPUserParentRoleId];
        }
        system.debug('@@@@@@@@@@@@@@@@@@@@ Groups:....'+lstGroup);
        List<string> SPUserGroupId = new List<string>();
        if(lstGroup.size()>0){
            for(Group objGroup : lstGroup){
                SPUserGroupId.add(objGroup.Id);
            }
        }
        
        List<String> ContactIDs = new List<string>();
        if(lstContact.size()>0){
            for(contact objContact : lstContact){
                ContactIDs.add(objContact.id);
            }
        }
        if(lstRelatedEmails.size()>0){
           for(CC_Related_Email__c objRelatedEmail : lstRelatedEmails){
               ContactIDs.add(objRelatedEmail.contact__r.Id);
           }     
        }
        
        if(lstContact.size()>0 && lstGroup.size()>0){
            lstConShare=[select UserOrGroupId,RowCause,Id,ContactId,ContactAccessLevel From ContactShare where (UserOrGroupId in :SPUserGroupId or UserOrGroupId =:OwnerId) and (ContactAccessLevel='All' or ContactAccessLevel='Edit') and ContactId in :ContactIDs];
        }
        
        if(lstConShare.size()>0){
            return lstConShare[0].ContactId;
        }
        
        lstAccShare = [Select a.UserOrGroupId, a.RowCause, a.Id, a.ContactAccessLevel,AccountId  From AccountShare a where a.accountId in :lstAccountIds and (UserOrGroupId in :SPUserGroupId or UserOrGroupId =:OwnerId) and (ContactAccessLevel='All' or ContactAccessLevel='Edit')];
        if(lstAccShare.size()>0){
            for(Contact objCon : lstContact){
                if(objCon.AccountId == lstAccShare[0].AccountId){
                    return objCon.Id;
                }
            }
            for(CC_Related_Email__c objRelEmail : lstRelatedEmails){
                if(objRelEmail.Contact__r.AccountId == lstAccShare[0].AccountId){
                    return objRelEmail.Contact__r.Id;
                }
            }
            
                
        }
        
        return null;
        
    }//web service method*/
}//web service