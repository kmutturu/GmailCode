public class jDockController{

    public string output {get; set;}
    public string table {get; set;}
    public string url {get; set;}
    public jDockController(){
        string s = ApexPages.currentPage().getHeaders().get('Host');
        Schema.Describesobjectresult result = Schema.Sobjecttype.SMS_Gateway__C;
        string objId = result.getKeyPrefix()+ '/e';
        url='https://'+s+'/'+objId;
        table = 'home';
        fireQuery();
    }
    
    public PageReference fireQuery()
    {
        output = '';
        output += '<table cellpadding=10 class=data>';
        if(table == 'checklist')
        {
           checklist();
        }
        else if(table == 'gateway')
        {
            gateway();
        }
        
        else if(table == 'singlesms')
        {
           singlesms();
        }
        
        else if(table == 'bulksms')
        {
            bulksms();
        }
        
        else if(table == 'home')
        {
            output += '<br/> <br/><br/><br/><br/><br/>';
            output += '<tr><th colspan=3 class=heading>Open SMS</th></tr>';
            output += '<br/> <br/><br/><br/>';
            output += '<tr><td>Open SMS is an application where you can send SMS reminders or Bulk SMS messages through your desired gateway.<br/><br/>';
            output += 'This messaging can help your users communicate with their contacts via SMS when tasks are created.<br/><br/>';
            output += 'It also provides user feasibility to send Bulk SMS to selected Contacts to broadcast messages to your contacts.<br/></td></tr>';
            
        }
           
        
        output += '</table>';
        system.debug('$$$$' + table);
        return null;
    }


    public string checklist()
    {
            output += '<br/><br/><br/><br/><br/><br/><br/><br/><br/>';
            output += '<tr><th colspan=5 class=heading>List of Components Used in OPEN SMS</th></tr>';
            output += '<br/> <br/><br/><br/>';
            output += '<tr><th><U>VF Pages</u></th><th><u>Apex Classes</u></th><th><u> Page Layouts</u></th><th><u> Triggers</u></th><th><u> Objects</u></th></tr>';
            output +=' <tr><td>Contacts</td><td>SendSMSCallout</td><td>SMS_Task Layout </td><td>Contrig</td> <td> SMS Gateway</td></tr>';
            output +=' <tr><td>Leads</td><td>SendContactBulkSMS</td><td>SMS_Event Layout</td><td>Leadtrig</td><td></td></tr>';
            output +=' <tr><td></td><td>SendContactBatchSMS</td><td></td><td>SMSTask trigger</td><td></td></tr>';
            output +=' <tr><td></td><td>SendLeadBulkSMS</td><td></td><td>SMSEventTrig</td><td></td></tr>';
            output +=' <tr><td></td><td>SendLeadBatchSMS</td><td></td><td>Trigdefault</td><td></td></tr>';
            output +=' <tr><td></td><td></td><td></td><td>TrigdefaultSMS</td><td></td></tr>';
        return output;   
    }

    public string bulksms()
    {
            output += '<br/> <br/><br/><br/><br/><br/><br/><br/><br/>';
            output += '<tr><th colspan=3 class=heading>Bulk SMS Settings</th></tr>';
            output += '<br/> <br/><br/><br/>';
            output += '<tr><td>With the Bulk SMS feature you can send multiple SMS messages to selected Contacts and can create a Task for those SMS messages<br/><br/>';
            output += 'Step 1: Go to Contacts Saerch Layout on Contacts in Customize Setup.<br/><br/>';
            output += 'Step 2: Add the "Bulk SMS" list View button to the Contacts page.  <br/><br/>';
            output += 'Step 3: Now go the Contacts Tab and Clik on "Go".<br/><br/>';
            output += 'Step 4: You will get the list of Contacts in your organisation with Bulk SMS button on the top of the page.  <br/><br/>';
            output += 'Step 5: Select your Contacts and Click on Bulk SMS button.<br/><br/>';
            output += 'Step 6: You will be redirecetd to another page. Type your message and Click on Send button.<br/><br/>';
            output += 'Step 7: You will get Summary report as a Tab in the Same page based on your selected Contacts and setup your SMS Gateway.<br/><br/>';
            output += 'Step 8: If you select large number of Contacts, no summary report will be displayed.<br/><br/>';
            output += 'Step 9: Tasks will be created to the Users you selected and SMS report can be viewed on your Home Page based on Gateway response.<br/><br/>';                 
            output += 'Step 10: You can view your Day to Day SMS report on your Dashboard in Home Page.<br/><br/> </td></tr>';
        return output;
        
    }


    public string singlesms()
    {
            output += '<br/> <br/><br/><br/><br/><br/><br/><br/><br/>';
            output += ' <tr><th colspan=4 class=heading>Single SMS Settings</th></tr>';
            output += '<br/> <br/><br/><br/>';
            output += ' <tr><td> This feature can be used to notify you when your Task or Event is created; in addition the assigned to User will be notified with an SMS.<br/><br/>After Installing the Package, steps to be followed:<br/><br/>';
            output += ' Step 1: Go to the Task Page Layouts on Activities in Customize.<br/><br/>Step 2: Click on Page Layout Assignment.';
            output += ' <br/><br/>Step 3: Change the Page Layout to SMS_Task Layout and Click on Save.';
            output += ' <br/><br/>Step 4: Now you can find "Send SMS" Check box on the Task Page Layout.';
            output += ' <br/><br/>Step 5: Create a Task and Check "Send SMS" and save it.';
            output += ' <br/><br/>User will be intimated about the Task with SMS.<br/><br/>';
            output += ' The same steps are to be followed in Event also.';
            output += ' <br/><br/>Note: User will need to have a Mobile number assigned.';
            output += ' </td></tr>';
        return output;
    
    }
    public string gateway()
    {
            output += '<br/> <br/><br/><br/><br/><br/><br/><br/><br/>';
            output += '<tr><th colspan=4 class=heading>Configuring SMS Gateway</th></tr>';
            output += '<br/><br/><br/><br/>';
            output += '<tr><td>To use the Open SMS you must configure your SMS gateway so the Open SMS can send messages.<br/>';
            output += '<tr><td>To Configure your gateway.<br/>';
            output += '<tr><td><a href="'+url+'">Click Here</a><br/><br/>';
            output += 'Note:Before Configuring your Gateway, get the Limit(Number of Contacts that can be sent in single POST)<br/>';
            output += 'and URL to post from your desired SMS Gateway.<br/><br/>Based on the URL given, it will be divided into parts.';
            output +='</td></tr>';
        return output;
    }
    
}