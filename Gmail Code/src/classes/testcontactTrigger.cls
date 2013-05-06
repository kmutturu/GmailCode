@ istest

private class  testcontactTrigger{

    static public testmethod void testcontacttrigMethod()
    {    
         
    try{
        contact c1 =new contact();
        c1.lastname='charan';
        c1.mobilephone='12345678678';
        insert c1;
        contact c2 =new contact();
        c2.lastname='charan';
        c2.mobilephone='12345678678';
        insert c2;

        }
        catch(exception e){}
        
               

}
}