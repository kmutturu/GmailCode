public class EasySendEmail{ 

Contact con;

public EasySendEmail(ApexPages.StandardController controller){
        this.con=(Contact)controller.getRecord();
    }
    
    
    public PageReference SendEmail(){
        Contact recipient = [SELECT id, firstname FROM Contact Where Id = '00390000004qerfAAA'];
        
        system.debug('debug--->' + UserInfo.getUserId());
        Messaging.SingleEmailMessage mail = new Messaging.SingleEmailMessage(); 
        mail.setTargetObjectId(recipient.Id);
        mail.setTemplateId('00X90000000o94J');
        system.debug('mail--->' + mail);
        Messaging.sendEmail(new Messaging.SingleEmailMessage[] { mail });
        return new PageReference('/' + con.id);

    }
}