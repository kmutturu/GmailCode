global class TimeClass implements schedulable {
	global static void execute(SchedulableContext sc)
	{
		Account objAcct = new Account();
		objAcct.name = 'Account at 8.7AM';
		insert objAcct;
	}
	
}