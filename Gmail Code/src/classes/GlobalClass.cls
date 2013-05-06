global with sharing class GlobalClass {

    webservice static void getAcct(string idAcct){
        if(idAcct != null && idAcct != ''){
            list<account> lstAcct = new list<account>();
            lstAcct = [select id,name from account];
            system.debug('the list of accounts'+lstAcct);
            list<account> lstAct = new list<account>();
            if(lstAcct.size() > 0){
                for(account objAccount : lstAcct){
                    objAccount.phone = '1234567890';
                    objAccount.Site = objAccount.name;
                    lstAct.add(objAccount);
                }
                update lstAct;
            }
        }
    }
}