@isTest
Private class TestCampTrigger{
    static testMethod void Mytest(){
        campaign objcampaign = new Campaign();
        objcampaign.name = 'SBL Utilization';
        insert objcampaign;
        
        
        lead objlead = new lead();
        objlead.lastname = 'test';
        objlead.company = 'testcompany';
        insert objlead;
        
        CampaignMember objcm = new CampaignMember();
        objcm.campaignid = objcampaign.id;
        objcm.leadid = objlead.id;
        insert objcm;
    }
    static testMethod void Mytest1(){
        campaign objcampaign = new Campaign();
        objcampaign.name = 'Global Currency';
        insert objcampaign;
        
        
        lead objlead = new lead();
        objlead.lastname = 'test';
        objlead.company = 'testcompany';
        insert objlead;
        
        CampaignMember objcm = new CampaignMember();
        objcm.campaignid = objcampaign.id;
        objcm.leadid = objlead.id;
        insert objcm;
    }
    static testMethod void Mytest3(){
        campaign objcampaign = new Campaign();
        objcampaign.name = 'PLA Opportunity';
        insert objcampaign;
        
        
        lead objlead = new lead();
        objlead.lastname = 'test';
        objlead.company = 'testcompany';
        insert objlead;
        
        CampaignMember objcm = new CampaignMember();
        objcm.campaignid = objcampaign.id;
        objcm.leadid = objlead.id;
        insert objcm;
    }
    static testMethod void Mytest4(){
        campaign objcampaign = new Campaign();
        objcampaign.name = 'Tailored Lending';
        insert objcampaign;
        
        
        lead objlead = new lead();
        objlead.lastname = 'test';
        objlead.company = 'testcompany';
        insert objlead;
        
        CampaignMember objcm = new CampaignMember();
        objcm.campaignid = objcampaign.id;
        objcm.leadid = objlead.id;
        insert objcm;
    }
    static testMethod void Mytest6(){
        campaign objcampaign = new Campaign();
        objcampaign.name = 'PLA Unreturned';
        insert objcampaign;
        
        
        lead objlead = new lead();
        objlead.lastname = 'test';
        objlead.company = 'testcompany';
        insert objlead;
        
        CampaignMember objcm = new CampaignMember();
        objcm.campaignid = objcampaign.id;
        objcm.leadid = objlead.id;
        insert objcm;
    }
    static testMethod void Mytest5(){
        campaign objcampaign = new Campaign();
        objcampaign.name = 'FA Prioritization';
        insert objcampaign;
        
        
        lead objlead = new lead();
        objlead.lastname = 'test';
        objlead.company = 'testcompany';
        insert objlead;
        
        CampaignMember objcm = new CampaignMember();
        objcm.campaignid = objcampaign.id;
        objcm.leadid = objlead.id;
        insert objcm;
    }
}