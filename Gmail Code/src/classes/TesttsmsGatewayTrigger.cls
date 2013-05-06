@ istest

private class  TesttsmsGatewayTrigger{

static public testmethod void testsmsGatewayMethod()
{
    SMS_Gateway__c objSmsgateWay=new SMS_Gateway__c(); 
    objSmsgateWay.name='dummy';
    objSmsgateWay.Active__c=true;
    objSmsgateWay.Bulk_SMS_Post_URL__c='www.yahoo.com';
    objSmsgateWay.Bulk_SMS_To_List__c='gasfjdhd';
    objSmsgateWay.Default__c=true;
    objSmsgateWay.LIMIT__c=25;
    objSmsgateWay.Separator__c=',';
    objSmsgateWay.SMS_Credentials__c='helloooooo';
    objSmsgateWay.SMS_POST_URL__c='www.yahoo.com';
    objSmsgateWay.SMS_To_List__c='jdskfhsjk';
    try{
    insert objSmsgateWay;
    }
    catch(exception ex){}
}
}