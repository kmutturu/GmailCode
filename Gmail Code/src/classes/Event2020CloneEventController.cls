public class Event2020CloneEventController {
    private ApexPages.StandardController controller{get;set;}
    private lead eve {get;set;}
    public ID newRecordId{get;set;}

    public Event2020CloneEventController(ApexPages.StandardController controller) {
    
        this.controller=controller;
        eve = (lead)controller.getRecord();

    }
    public PageReference cloneEvent(){
        
        Savepoint sp =Database.setSavepoint();
        lead newEVE;
        
        try {
            eve=[Select Id , lastName,company  from lead where id = :eve.id ];
            
            newEVE=eve.clone(false);
            //insert newEVE;
            
            newRecordId = newEVE.id;
            
            }
        catch(Exception e){
        
            Database.rollback(sp);
            ApexPages.addMessages(e);
            return null;           
        }
        return new PageReference('/'+EVE.id+'/e?retURL=%2F'+EVE.id);
        }
  }