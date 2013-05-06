trigger SubUpdate on Subscriber__c (before insert) {
Set<String> AddressSet = new Set<String>();
Set<String> LocSet = new Set<String>();
Set<String> ZipSet = new Set<String>();
                    for(Subscriber__c s: Trigger.New)
                             {
                                      AddressSet.add(s.street_address__c);
                                      LocSet.add(s.loc__c);
                                      ZipSet.add(s.zip_code__c);
                              }
                              
list<Fiber_Qualified_Address__c> gpon = [select id,name, street_address__c, loc__c, zip_code__c from Fiber_Qualified_Address__c where street_address__c IN: AddressSet
and loc__c IN: LocSet
and zip_code__c IN: ZipSet];
        if(gpon.size()>0)
        {
                Map<ID, String> FQAID = new Map<ID, String>();
                for(Fiber_Qualified_Address__c FQAID2: gpon)
                {
                Map<String, Fiber_Qualified_Address__c> FQAMap = new Map<String, Fiber_Qualified_Address__c>();
                for(Fiber_Qualified_Address__c foa: gpon)
                {
                            FQAMAP.put(foa.street_address__c + '' + foa.loc__c + '' + foa.zip_code__c, foa);
                }
                for(Subscriber__c s: Trigger.new)
                {
                            if(FQAMAP.containsKey(s.street_address__c + '' + s.loc__c + '' + s.zip_code__c))
                            s.fiber_address__c = FQAMap.get(s.street_address__c + '' + s.loc__c + '' + s.zip_Code__c).Id;
                            }
             }
}
}