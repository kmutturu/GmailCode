@isTest 
    private  class TestMarkDeleteAccount{
    static testMethod void myTest1() {
        test.starttest();
      Account  Acc = new Account();
      Acc.Name = 'Test Acc1';
      Acc.Mark_for_Delete__c = true;
      insert Acc;
      ApexPages.currentPage().getParameters().put('id', Acc.id);
      ApexPages.StandardController sc = new  ApexPages.StandardController(Acc);
      MarkDeleteAccount obj = new MarkDeleteAccount(sc);
      obj.save();
      obj.Cancel();
      test.stoptest();
      
      
    }    
    
   
}