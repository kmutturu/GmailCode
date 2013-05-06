@isTest
private class mytestclass{
    static testMethod void mytest(){
        Account obj = new account();
        obj.name = 'testaccountfortesting';
        insert obj;
        GlobalClass.getAcct(obj.id);
    }
}