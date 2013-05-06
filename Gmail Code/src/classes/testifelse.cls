@istest
private class testifelse{
    static testmethod void etsh(){
        contact obj = new contact();
           obj.lastname = 'test';
           insert obj;
        ifelsecover obj1 = new ifelsecover();
        obj1.update1();
    }
    static testmethod void etsh2(){
    contact objc = new contact();
    objc.lastname = 'tetete';
        ifelsecover obj = new ifelsecover();
        obj.update1();
    }
}