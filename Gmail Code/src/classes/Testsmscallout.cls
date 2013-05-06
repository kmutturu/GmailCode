/*Class Name : testSmsCallout                   
 * Author : Charan & Jaya Lakshmi 
 * Date   : 02nd Feb 2011
 * Purpose: To test the codecoverage of sendsms class.
 * Modification History : 
 * 
*/
 


@isTest

private class Testsmscallout{

static testmethod void testsendsmsMethod()
{
    SendSmsCallout.sendSMSmethod('Test','Test comments','9849655464');
} 

}