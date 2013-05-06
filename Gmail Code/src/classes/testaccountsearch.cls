@isTest
private class testaccountsearch{

    static testmethod void testm(){
    
        test.starttest();
        account act = new account();
        act.name = 'test';
        insert act; 
       test.stoptest();
        
        accountsearch obj = new accountsearch();
        obj.strval = act.name;
        obj.assig = true;
        
        
        obj.dosearch();
        obj.getlstAct();
        

    }
    
    static testmethod void testm1(){ 
    
    
        contact obj = new contact(lastname = 'testcon');
        insert obj;
        testglobal.mymethod(obj.lastname); 
    }
}