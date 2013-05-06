global class ReadyForTraining {

WebService static void SendEmailNotification(string Account, string Production, string Owner_FirstName, string Owner_LastName, string Go_Live_Date, string Product, string FUSION_Tools_User, string FUSION_Tools_Pass, string CallSource_User, string CallSource_Pass, string GA_User, string GA_Pass, string Production_Link) {

//create a mail object to send a single email.
Messaging.SingleEmailMessage mail = new Messaging.SingleEmailMessage();

//set the email properties
mail.setToAddresses(new string[] {'bpitts@clickmotive.com'});
mail.setSenderDisplayName('Implementation Team');
mail.setSubject('' + Account + ' - Ready For Training');
mail.setHtmlBody('Support,<br /><br />' + Account + ' is ready to have their training scheduled.<br /><br />Production: ' + Production + '<br />Owner: ' + Owner_FirstName + ' ' + Owner_LastName + '<br />Go Live Date: ' + Go_Live_Date + '<br />Product(s): ' + Product + '<br /><br /><table border="1" bordercolor="black"><tr bgcolor="#D4D4D4"><td><strong>Tool</strong></td><td><strong>Username</strong></td><td><strong>Password</strong></td></tr><tr><td>FUSION Tools</td><td>' + FUSION_Tools_User + '</td><td>' + FUSION_Tools_Pass + '</td></tr><tr><td>CallSource</td><td>' + CallSource_User + '</td><td>' + CallSource_Pass + '</td></tr><tr><td>Google Analytics</td><td>' + GA_User + '</td><td>' + GA_Pass + '</td></tr></table><br /><br />Production Record Link: ' + Production_Link + ''
);

//send the email
Messaging.sendEmail(new Messaging.SingleEmailMessage[] { mail } );

}
}