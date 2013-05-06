global with sharing class StartOrchestration{
webservice static void basicAuthCallout(){
        //system.debug('strSpecialRun'+strSpecialRun);
        //if(strBillingCycleId != '' && strFlag == '1' && strSpecialRun != ''){
            Http http = new Http();
            HttpRequest req = new HttpRequest();
            req.setEndpoint('http://66.77.195.92/HttpReceiveStatement');
            req.setMethod('GET');
            //req.setBody(strBillingCycleId);  
            HTTPResponse res = http.send(req);
            System.debug('STATUS:'+res.getStatus());
            System.debug('STATUS_CODE:'+res.getStatusCode());
            System.debug('----Responce----'+res.getBody());
        //}
     }
}