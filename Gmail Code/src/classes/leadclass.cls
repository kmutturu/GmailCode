public class leadclass{

    list<campaignmember> lstCm = new list<campaignmember>();
   
   public boolean blren = false;
   
   public void setblren(boolean value){
       blren = value;
   }
   
   public boolean getblren(){
       return blren;
   }
   
    public leadclass(ApexPages.StandardController controller) {
        list<lead> lstLead = [Select (Select Id,campaign.name,campaign.status,campaignid From CampaignMembers) cm From Lead  where id = :apexpages.currentpage().getparameters().get('id')];
       
       for(lead objlead : lstLead){
           system.debug('****'+objlead.CampaignMembers.size());
           if(objlead.CampaignMembers.size() == 0)
                blren = true;
            lstCm.addall(objlead.CampaignMembers);
        }
        
    }

    public list<CampaignMember> getCampigns(){
        
       return lstCm;
     
       
       
        
    }
    
}