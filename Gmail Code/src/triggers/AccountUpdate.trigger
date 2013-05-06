trigger AccountUpdate on Account bulk(before insert, before update,before delete) {
   
  if(trigger.isinsert){ 
    map<string,string> SODesToName = new map<string,string> {
    'TEC Dom. Sales Org' => 'TECD',
    'TEC Exp. Sales Org' => 'TECE',
    'TOC Dom. Sales Org' => 'TOCD',
    'TOC Exp. Sales Org' => 'TOCE',
    'TPCC Dom. Sales Org'=>'TPCD ',
    'TPCC Exp. Sales Org'=>'TPCE ',
    'TPL Dom. Sales Org'=>'TPLD ',
    'TPL Exp. Sales Org'=>'TPLE ',
    'TSC Dom. Sales Org'=>'TSCD',
     'TSC Exp. Sales Org'=>'TSCE '
  };
    map<string,string> SONameToDes = new map<string,string>();
        for(string key:SODesToName.keySet())
        SONameToDes.put(SODesToName.get(key),key);
        
    map<string,string> DCDesToName = new map<string,string> {
    'TOC-Direct to Cust'=>'DC',
    'TPC-Direct Sales'=>'DI',
    'TEC-Direct Sales'=>'DS',
    'TSC-Direct to Cust'=>'DT',
    'TPL-End Users'=>'EU',
    'Group Companies'=>'GR',
    'TSC-Indenting Agent'=>'IA',
    'TOC-Indirect to Cust'=>'IC',
    'TPC-Indirect Sales'=>'ID',
    'TSC-Indirect to Cust'=>'IN',
    'TEC-Indirect Sales'=>'IS',
    'TPL-To Dealers'=>'TD'
  };
    map<string,string> DCNameToDes = new map<string,string>();
        for(string key:DCDesToName.keySet())
        DCNameToDes.put(DCDesToName.get(key),key);
            
    for(Account Acc:trigger.new) {
    if(SODesToName.containsKey(Acc.Sales_Organization_Des__c ) && (Trigger.isInsert || Trigger.oldMap.get(Acc.id).Sales_Organization_Des__c  != Acc.Sales_Organization_Des__c ))
    Acc.Sales_Organization__c  = SODesToName.get(Acc.Sales_Organization_Des__c );

    if(SONameToDes.containsKey(Acc.Sales_Organization__c ) && (Trigger.isInsert || Trigger.oldMap.get(Acc.id).Sales_Organization__c  != Acc.Sales_Organization__c ))
    Acc.Sales_Organization_Des__c  = SONameToDes.get(Acc.Sales_Organization__c );
    
    if(DCDesToName.containsKey(Acc.Distribution_Channel_Des__c ) && (Trigger.isInsert || Trigger.oldMap.get(Acc.id).Distribution_Channel_Des__c  != Acc.Distribution_Channel_Des__c ))
    Acc.Distribution_Channel__c  = DCDesToName.get(Acc.Distribution_Channel_Des__c );

    if(DCNameToDes.containsKey(Acc.Distribution_Channel__c ) && (Trigger.isInsert || Trigger.oldMap.get(Acc.id).Distribution_Channel__c  != Acc.Distribution_Channel__c ))
    Acc.Distribution_Channel_Des__c  = DCNameToDes.get(Acc.Distribution_Channel__c );
    
    }
    }

}