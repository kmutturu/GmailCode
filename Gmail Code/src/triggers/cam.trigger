trigger cam on CampaignMember (after insert) {

   
     list<id> lstLeadIds = new list<id>();  
    list<Lead> lstLeads = new list<Lead>();   
    list<campaign> lstCampaignNames = new list<campaign>();
   
    for(CampaignMember objCampaignMember  : trigger.new){
        lstLeadIds.add(objCampaignMember.leadid);
    }
            
    map<id,lead> mapLeads;
    if(lstLeadIds.size() > 0)
       mapLeads = new map<id,lead>([select id from lead where id in :lstLeadIds]);
    
    
    for(CampaignMember objCampaignMember  : [select id,campaign.name,leadid from CampaignMember where id in :trigger.newMap.keyset()]){
        
        if(objCampaignMember.leadid != null){
            
            if(mapLeads.get(objCampaignMember.leadid) != null){
            
                Lead objLead = new Lead();
                objLead = mapLeads.get(objCampaignMember.leadid);
                system.debug('*'+objCampaignMember.Campaign.name);
                if(objCampaignMember.Campaign.name == 'SBL Utilization'){
                    objLead.SBL_Utilization__c = objCampaignMember.id;
                    lstLeads.add(objLead);
                }
                else if(objCampaignMember.Campaign.name == 'Global Currency'){
                    objLead.Global_Currency_Campaign__c = objCampaignMember.id;
                    lstLeads.add(objLead);
                }
                else if(objCampaignMember.Campaign.name == 'PLA Unreturned'){
                    objLead.PLA_Unreturned__c = objCampaignMember.id;
                    lstLeads.add(objLead);
                }
                else if(objCampaignMember.Campaign.name == 'PLA Opportunity'){
                    objLead.PLA_Opportunity__c = objCampaignMember.id;
                    lstLeads.add(objLead);
                }
                else if(objCampaignMember.Campaign.name == 'Tailored Lending'){
                    objLead.Tailored_Lending_Campaign__c = objCampaignMember.id;
                    lstLeads.add(objLead);
                }
                else if(objCampaignMember.Campaign.name == 'FA Prioritization'){
                    objLead.FA_Prioritization__c = objCampaignMember.id;
                    lstLeads.add(objLead);
                }
            
            }
            
        }
    }
    if(lstLeads.size() > 0)
        update lstLeads; 

}