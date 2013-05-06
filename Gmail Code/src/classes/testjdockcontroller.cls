@isTest
class testjdockcontroller {
   
   static testmethod void test1() {
   
   logoController  obj= new logoController ();
   
   obj.imageUrl = 'test';
   
   obj.getlogo();
    obj.imageUrl = null;
   obj.getlogo(); 
   
  
   }
   static testmethod void test2() {
   
   contact objc = new contact();
   objc.lastname = 'test';
   insert objc;
   
   logoController  obj= new logoController ();
   
  
   obj.getlogo(); 
   
  
   }
    
   
   
}