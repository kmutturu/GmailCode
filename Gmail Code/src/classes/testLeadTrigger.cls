@ istest

private class  testLeadTrigger{

    static public testmethod void testLeadtrigMethod()
    {    
         
    try{
        Lead c1 =new Lead();
        c1.lastname='charan';
        c1.mobilephone='12345678678';
        c1.company='appshark';
        insert c1;
        Lead c2 =new Lead();
        c2.lastname='charan';
        c2.mobilephone='12345678678';
                c2.company='appshark';
        insert c2;

        }
        catch(exception e){}
        
               

}
}