public class searchcontact{

    public string conval{get;set;}
    
    public boolean bren{get;set;}
    
    public string strEAVPageMessage{get;set;}
    
    
    
    
    list<contact> cons =  new list<contact>();
    
    
    public searchcontact(){
    	system.debug(ApexPages.currentPage().getUrl());
    	
    	if(ApexPages.currentPage().getUrl() != null){
    		string str = ApexPages.currentPage().getUrl().split('/')[2];
    		system.debug(str);
    		system.debug('eneterd in first if'+EAV_Messages__c.getValues('ContactSearch').Message__c);
    		if(EAV_Messages__c.getValues('ContactSearch').Message__c != null){
				
				strEAVPageMessage = EAV_Messages__c.getvalues('ContactSearch').message__c;
    		}
    	}
    	
    	
    }
    
    public void search(){
    
        string con = '%' + conval + '%';
        
        cons = [select id,lastname from contact where lastname like :con];
        
        if(cons.size() > 0)
            bren = true;
    
    }
    
    public list<contact> getcons(){
    
        return cons;
    }




}