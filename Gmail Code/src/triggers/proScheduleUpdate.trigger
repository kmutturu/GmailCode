trigger proScheduleUpdate on OpportunityLineItem (before update,before insert, after update) {
    /*Id sysAdminId = [Select Id, Name from User LIMIT 1].Id;
    set<id> sids = trigger.oldmap.keyset();
    list <OpportunityLineItemSchedule> schedule = [select Id, ScheduleDate,Revenue from OpportunityLineItemSchedule where OpportunityLineItemId in :sids];
    for (OpportunityLineItem oppProd : trigger.old)
        {
            for(OpportunityLineItemSchedule objLineItemSchedule : schedule){
                if (objLineItemSchedule.ScheduleDate.Month() < System.Today().Month() && objLineItemSchedule.ScheduleDate.Year() <= System.Today().Year() || objLineItemSchedule.ScheduleDate.Year() < System.Today().Year() && UserInfo.getUserId() !=sysAdminID)
                    oppProd.addError('This opp Product Schedule may not be modify. Contact System Administrator');                                               
            }
        }*/
        
        
     if(trigger.isinsert){
     
         system.debug(trigger.new);
         list<string> sid = new list<string>();
         set<id> sopids = new set<id>();
         map<string,string> soppid = new map<string,string>();
         set<string> soppval = new set<string>();
         map<string,string> mapfinal = new map<string,string>();
         for(OpportunityLineItem  obj : trigger.new){
             if(obj.fladvalue__c != null){
                 sid.add(obj.fladvalue__c);                 
                soppid.put(obj.opportunityid,obj.fladvalue__c);  
                sopids.add(obj.opportunityid);
             }
         }
        
         
         map<string,PrdDetails__c> mdetails = PrdDetails__c.getall();
         
         system.debug('********'+mdetails.keyset());
        
         
         for(PrdDetails__c obj : mdetails.values()){         
             mapfinal.put(obj.product_code__c,obj.name);         
         }
                    
         for(string str : sid){         
             soppval.add(mapfinal.get(str));
             //PrdDetails__c myCS1 = PrdDetails__c.getValues(str);
             //soppval.add(mycs1.name);
         }
        system.debug('***************'+soppval);
        
        list<opportunity> lstoops = [select id,Digital_Marketing_Solution__c from opportunity where id in :sopids];
        
       /* for(OpportunityLineItem oplid :  soppid.values()){
            opportunity opp = new opportunity(id=oplid.opportunityid);
            //opp.id = oplid.opportunityid;
            if(opp.Digital_Marketing_Solution__c != null)
                opp.Digital_Marketing_Solution__c = opp.Digital_Marketing_Solution__c + mapfinal.get(oplid.fladvalue__c);
            else
                opp.Digital_Marketing_Solution__c = mapfinal.get(oplid.fladvalue__c);
            update opp;
        
        }*/
        for(opportunity opp : lstoops ){
        
        if(opp.Digital_Marketing_Solution__c  != null && !opp.Digital_Marketing_Solution__c.contains(mapfinal.get(soppid.get(opp.id))))
            opp.Digital_Marketing_Solution__c = opp.Digital_Marketing_Solution__c + ';' + mapfinal.get(soppid.get(opp.id));
           if(opp.Digital_Marketing_Solution__c  == null)
               opp.Digital_Marketing_Solution__c = mapfinal.get(soppid.get(opp.id));
           
        
        update opp;
        
        }
        
        
         /*for(PrdDetails__c strprodcode : mdetails.values()){
             soppvalmdetails.
         }*/
         
         //list<PricebookEntry> lstpbe = [SELECT Id, Pricebook2Id, ProductCode, Product2Id, name FROM PricebookEntry];
     
     }
          
}