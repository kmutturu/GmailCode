@isTest 
private class TestMassCreation{
    
    static testMethod void myTest() {
      List<Case > lstILI = new List<Case >();
      ApexPages.StandardSetController sc = new  ApexPages.StandardSetController(lstILI);
      
      
      Account objAcc = new Account();
      objAcc.Name = 'test';
      insert objAcc;
      
      Contact objcon = new Contact();
      objcon.LastName = 'test';
      objcon.AccountID = objAcc.ID;
      insert objcon;
      
      Case objca = new Case();
      objca.Origin = 'Phone';
      objca.Status = 'Closed';
      insert objca;
      
      test.starttest();
      ApexPages.currentPage().getParameters().put('id', objcon.id);
      MassCreation obj = new MassCreation();
      obj.addrow();
      obj.deleteRow();
      obj.save();
      obj.cancel();
      test.stoptest();
     
    }
    
     static testMethod void myTest1() {
     
      MassCreation obj = new MassCreation();
      obj.Cases.clear();
       obj.addrow();
     
     }
    
    
}