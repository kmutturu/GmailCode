global with sharing class ButtonInvocation {
    
    webservice static void  getMyAccoount(string AcctId){
        if(AcctId != null && AcctId != ''){
            list<account> lstAct = [select id from account where id =:AcctId];
            lstAct[0].Phone = '1234567890';
            update lstAct;
        }
        else
        {
            contact objcontact = new contact();
            objcontact.lastname = 'test else';
            insert objcontact;  
        }
    }
    
    
    

}