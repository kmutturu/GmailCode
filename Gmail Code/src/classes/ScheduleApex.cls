global with sharing class ScheduleApex implements Schedulable {
	
	global void execute(SchedulableContext sc){
		
		Account act = new Account();
		act.name = 'schedulable account';
		insert act;
		
	}
	
	
	public void getData(string strval){
		system.debug('test'+strval);
	}

}