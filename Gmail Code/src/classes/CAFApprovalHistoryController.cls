public class CAFApprovalHistoryController {
    public String cafId {get;set;}
    public List<ProcessInstanceHistory> getApprovalSteps() {
      If (cafId != null) {
        CAF__c cafs = [Select Id, Name,(Select TargetObjectId, SystemModstamp, StepStatus, RemindersSent, ProcessInstanceId, OriginalActorId, IsPending, IsDeleted, Id, CreatedDate, CreatedById, Comments, ActorId From ProcessSteps order by SystemModstamp desc) from CAF__c where Id = :cafId];
        return cafs.ProcessSteps;
      }
      return new List<ProcessInstanceHistory> ();
    } 
}