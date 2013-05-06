public with sharing class mysimpleclass {

    Public void samplemethod1()
    {
        try
            {
            Integer a = 10;
            Integer b = a + 20;
            system.debug('The value of b is'+b);
            }
            catch (Exception e)
            {
            system.debug('Exception'+e);
            }
    }

}