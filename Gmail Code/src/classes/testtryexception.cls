public class testtryexception extends exception {
    static testmethod void testtry(){
        mysimpleclass  obj = new mysimpleclass ();
        obj.samplemethod1();
        
    }
    static testmethod void testtry1(){
        mysimpleclass  obj = new mysimpleclass ();
        throw new testtryexception();
        
    }
}