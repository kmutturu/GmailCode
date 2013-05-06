public class TestBot {
	@isTest
	private static void testBotController(){
		Account newAcc = new Account();
		newAcc.Name = 'test';
		insert newAcc;
		ApexPages.currentPage().getParameters().put('msg','get account id,name [name like \'*test*\']');
		BotController bot = new BotController();		
	}
}