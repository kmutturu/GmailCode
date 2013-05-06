// Star class
public with sharing class ShipOrder {
    //global variables
   /* String OrderId='';
    List<CC_Order__c> lstOrder = new List<CC_Order__c>();
    List<CC_Order__c> lstOrd = new List<CC_Order__c>();
    List<CC_Order_Line_Item__c> lstOrderLineItems = new List<CC_Order_Line_Item__c>();
    List<Service_provider__c> lstServ = new List<Service_provider__c>();
    String FromAddress = '';
    String ToAddress = '';
    String ownerid = '';
    Boolean flag = false;
    string Info = '';
    String ErrorMsg = '';
    string Phship = '';
    
    //end of global variables
    
    //start Constructor
    public ShipOrder(){
        system.debug('enetered into constructor');
        getOrderDetails();
        if(lstOrder.size()>0 ){
            FromAddress = ConstructFromAddress(lstOrder);
            ToAddress = ConstructToAddress(lstOrder);
        }
        system.debug('fromaddress'+FromAddress);
        system.debug('Toaddress'+ToAddress);
    }
    //end of constructor
    
    public String getToAddress(){
        return ToAddress;
    }
    public string getInfo(){
        if(Info == ''){
            getOrderDetails();
        }
        return Info;
    }
    public void setInfo(string value){
        Info = value;
    }
    public String getFromAddress(){
        return FromAddress;
    }
    public String getErrorMsg(){
        ErrorMsg = getInfo();
        return ErrorMsg;
    }
    //start getorderid method 
    public String getOrderID(){
        if(OrderId == ''){
            if(ApexPages.CurrentPage().getParameters().get('ID')!=''){
                 OrderId = ApexPages.CurrentPage().getParameters().get('ID');
            }
            else{
                OrderId = '0';
            } 
        }
        if(Phship == ''){
            if(ApexPages.CurrentPage().getParameters().get('PhShip')!=''){
                 Phship = ApexPages.CurrentPage().getParameters().get('Phship');
            }
        }
        return orderId;
    }//end of getorderid method
    
    //start getOrderDetails
    public CC_Order__c getOrderDetails(){
        if(OrderId == ''){
           OrderId = getOrderID();
        }
        system.debug('orderid'+OrderId);
        if(OrderId != '0'){
            lstOrder = [select id,Name,Transfer_to_Warehouse__r.Phone__c,Transfer_to_Warehouse__r.Name,Transfer_to_Warehouse__r.Address_1__c,Transfer_to_Warehouse__r.City__c,Transfer_to_Warehouse__r.State__c,Transfer_to_Warehouse__r.Zip__c,Transfer_to_Warehouse__r.Country__c,Type__c,Warehouse__r.Address_1__c,Warehouse__r.City__c,Warehouse__r.State__c,Warehouse__r.Country__c,Warehouse__r.Zip__c,Warehouse__r.Phone__c,Operating_Company__r.Pay_Or_Country_Code__c,Operating_Company__r.Client_Detail_Meter_Number__c,Operating_Company__r.Client_Detail_Account_Number__c,Operating_Company__r.Signature_Required__c,Operating_Company__r.User_Credential_Password__c,Operating_Company__r.User_Credential_Key__c,Operating_Company__r.Service_Type__c,Ownerid,Operating_Company__r.Drop_off_Type__c,Operating_Company__r.Physical_Country__c,Operating_Company__r.name,Contact__r.Name,Operating_Company__r.Billing_Contact__r.name,Operating_Company__r.Billing_Contact__r.Email_1__c,Operating_Company__r.Physical_Zip__c,Operating_Company__r.Physical_Street__c,Operating_Company__r.Physical_Street2__c,Operating_Company__r.Physical_City__c,Operating_Company__r.Physical_State__c,Operating_Company__r.Main_Phone__c,Account__r.ShippingCountry,Account__r.Billing_Email_Address__c,Contact__r.Email,Account__r.ShippingStreet,Account__r.ShippingCity,Account__r.ShippingState,Account__r.ShippingPostalCode,Account__r.Name,Account__r.Phone from CC_Order__c where id=:OrderId];
            system.debug('----lstOrder----'+lstOrder);
            system.debug('----lstOrder. accinfo----'+lstOrder[0].Account__r.ShippingPostalCode);
        }
        if(lstOrder.size()>0){
            lstOrderLineItems = [select id,Item__c,Item__r.Id,Item__r.Units__c,Quantity__c,Order__c,Qty_shipped__c,Invoice_Quantity__c,Order__r.Id,Order__r.Warehouse__c,Sale_Price__c,Back_Ordered_Count__c from CC_Order_Line_Item__c where Order__r.Id=:lstOrder[0].id];
            if(lstOrderLineItems.size() > 0){
                for(Integer iCount=0;iCount<lstOrderLineItems.size();iCount++){
                    Double Value = lstOrderLineItems[iCount].Quantity__c - lstOrderLineItems[iCount].Qty_shipped__c - lstOrderLineItems[iCount].Back_Ordered_Count__c;
                    if(Value > 0){
                        flag = true;
                        break;
                    }
                }
            }
            else{
                setInfo('No items to Ship');
                return null;
            } 
            if(flag == false){
                    setInfo('All the items are already Shipped');
                    return null;
            }
            ownerid = lstOrder[0].OwnerId;
            system.debug('ownerid'+ownerid);
            if(ownerid != null && ownerid != '')
                lstServ = [select id,Email_1__c,User__r.Email,Operating_Company__r.Billing_Contact__r.Email_1__c,Operating_Company__r.Pay_or_Country_Code__c,Operating_Company__r.Client_Detail_Meter_Number__c,Operating_Company__r.Client_Detail_Account_Number__c,Operating_Company__r.User_Credential_Password__c,Operating_Company__r.User_Credential_Key__c,Operating_Company__r.Service_Type__c,Operating_Company__r.Drop_off_Type__c,Operating_Company__r.Physical_Country__c,Operating_Company__r.name,Operating_Company__r.Billing_Contact__r.name,Operating_Company__r.Signature_Required__c,Operating_Company__r.physical_Zip__c,Operating_Company__r.Physical_Street__c,Operating_Company__r.Physical_Street2__c,Operating_Company__r.Physical_City__c,Operating_Company__r.Physical_State__c,Operating_Company__r.Main_Phone__c from Service_provider__c where User__c = :ownerid];
            if(PhShip == 'false'){
                if(OrderId != null && OrderId != '')
                    OrderShippingServices.getTransforOrderDetails(OrderId);
            }    
            return lstOrder[0];
        }
        else
            return null;
        
    }//end of order details
    
    //start constructing Toaddress in xml
    public String ConstructToAddress(List<CC_Order__c> lstOrder){
        String XMLString = '';
        system.debug('---lstOrder----'+lstOrder);
        if(lstOrder.size()> 0 && lstOrder[0].Type__c != 'Transfer'){
            if(XMLString == ''){
                XMLString = '<ToAddress>';
            }
            //Country
            if(lstOrder[0].Account__r.ShippingCountry != null)
                XMLString = XMLString+'<Country>'+lstOrder[0].Account__r.ShippingCountry+'</Country>';
            else
                XMLString = XMLString+'<Country>'+''+'</Country>';
                
            //Company
            if(lstOrder[0].Account__r.Name != null)
                XMLString = XMLString+'<Company>'+lstOrder[0].Account__r.Name+'</Company>';
            else
                XMLString = XMLString+'<Company>'+''+'</Company>';
                
            //ContactName
            if(lstOrder[0].Contact__r.Name != null)
                XMLString = XMLString+'<ContactName>'+lstOrder[0].Contact__r.Name+'</ContactName>';
            else
                XMLString = XMLString+'<ContactName>'+lstOrder[0].Account__r.Name+'</ContactName>';
            
            //Address1
            if(lstOrder[0].Account__r.ShippingStreet != null)
                XMLString = XMLString+'<Address1>'+lstOrder[0].Account__r.ShippingStreet+'</Address1>';
            else
                XMLString = XMLString+'<Address1>'+''+'</Address1>';
                
            //Address2    
            XMLString = XMLString+'<Address2>'+''+'</Address2>';
            
            //City    
            if(lstOrder[0].Account__r.ShippingCity != null)
                XMLString = XMLString+'<City>'+lstOrder[0].Account__r.ShippingCity+'</City>';
            else
                XMLString = XMLString+'<City>'+''+'</City>';
                
            //State    
            if(lstOrder[0].Account__r.ShippingState != null)
                XMLString = XMLString+'<State>'+lstOrder[0].Account__r.ShippingState+'</State>';
            else
                XMLString = XMLString+'<State>'+''+'</State>';
                
            //Zip    
            if(lstOrder[0].Account__r.ShippingPostalCode != null)
                XMLString = XMLString+'<Zip>'+lstOrder[0].Account__r.ShippingPostalCode+'</Zip>';
            else
                XMLString = XMLString+'<Zip>'+''+'</Zip>';
                
            //Phone    
            if(lstOrder[0].Account__r.Phone != null)
                XMLString = XMLString+'<Phone>'+lstOrder[0].Account__r.Phone+'</Phone>';
            else
                XMLString = XMLString+'<Phone>'+''+'</Phone>';
                
            //Ext    
            XMLString = XMLString+'<Ext>'+''+'</Ext></ToAddress>';
            //XMLString = XMLString+'<Country>'+lstOrder[0].Account__r.ShippingCountry+'</Country><Company>'+''+'</Company><ContactName>'+lstOrder[0].Account__r.Name+'</ContactName><Address1>'+lstOrder[0].Account__r.ShippingStreet+'</Address1><Address2>'+''+'</Address2><City>'+lstOrder[0].Account__r.ShippingCity+'</City><State>'+lstOrder[0].Account__r.ShippingState+'</State><Zip>'+lstOrder[0].Account__r.ShippingPostalCode+'</Zip><Phone>'+lstOrder[0].Account__r.Phone+'</Phone><Ext>'+''+'</Ext></FromAddress>';
        }
        else if(lstOrder[0].Type__c == 'Transfer'){
            system.debug('enetered in to transfer');
            if(lstOrder.size()>0){
                if(XMLString == ''){
                    XMLString = '<ToAddress>';
                }
                //Country
                if(lstOrder[0].Transfer_to_Warehouse__r.Country__c != null)
                    XMLString = XMLString+'<Country>'+lstOrder[0].Transfer_to_Warehouse__r.Country__c+'</Country>';
                else
                    XMLString = XMLString+'<Country>'+''+'</Country>';
                    
                //Company
                if(lstOrder[0].Transfer_to_Warehouse__r.Name != null)
                    XMLString = XMLString+'<Company>'+lstOrder[0].Transfer_to_Warehouse__r.Name+'</Company>';
                else
                    XMLString = XMLString+'<Company>'+''+'</Company>';
                    
                //ContactName
                if(lstOrder[0].Transfer_to_Warehouse__r.Name != null)
                    XMLString = XMLString+'<ContactName>'+lstOrder[0].Transfer_to_Warehouse__r.Name+'</ContactName>';
                else
                    XMLString = XMLString+'<ContactName>'+''+'</ContactName>';
                
                //Address1
                if(lstOrder[0].Transfer_to_Warehouse__r.Address_1__c != null)
                    XMLString = XMLString+'<Address1>'+lstOrder[0].Transfer_to_Warehouse__r.Address_1__c+'</Address1>';
                else
                    XMLString = XMLString+'<Address1>'+''+'</Address1>';
                    
                //Address2    
                XMLString = XMLString+'<Address2>'+''+'</Address2>';
                
                //City    
                if(lstOrder[0].Transfer_to_Warehouse__r.City__c != null)
                    XMLString = XMLString+'<City>'+lstOrder[0].Transfer_to_Warehouse__r.City__c+'</City>';
                else
                    XMLString = XMLString+'<City>'+''+'</City>';
                    
                //State    
                if(lstOrder[0].Transfer_to_Warehouse__r.State__c != null)
                    XMLString = XMLString+'<State>'+lstOrder[0].Transfer_to_Warehouse__r.State__c+'</State>';
                else
                    XMLString = XMLString+'<State>'+''+'</State>';
                    
                //Zip    
                if(lstOrder[0].Transfer_to_Warehouse__r.Zip__c != null)
                    XMLString = XMLString+'<Zip>'+lstOrder[0].Transfer_to_Warehouse__r.Zip__c+'</Zip>';
                else
                    XMLString = XMLString+'<Zip>'+''+'</Zip>';
                    
                //Phone    
                if(lstOrder[0].Transfer_to_Warehouse__r.Phone__c != null)
                    XMLString = XMLString+'<Phone>'+lstOrder[0].Transfer_to_Warehouse__r.Phone__c+'</Phone>';
                else
                    XMLString = XMLString+'<Phone>'+''+'</Phone>';
                    
                //Ext    
                XMLString = XMLString+'<Ext>'+''+'</Ext></ToAddress>';
            }
        }
        
    return XMLString;
    }//end of Toaddress xmlconstruction 
    
    //Start Constructing FromAddress xml
    public String ConstructFromAddress(List<CC_Order__c> lstOrder){
        String XMLString = '';
        if(lstOrder.size()>0){
            if(XMLString == ''){
                XMLString = '<FromAddress>';
            }
            
            //SenderEmail
            if(lstOrder.size()>0 && lstOrder[0].Operating_Company__r.Billing_Contact__r.Email_1__c != null){
                system.debug('SenderEmail'+lstOrder[0].Operating_Company__r.Billing_Contact__r.Email_1__c);
                XMLString = XMLString+'<SenderEmail>'+lstOrder[0].Operating_Company__r.Billing_Contact__r.Email_1__c+'</SenderEmail>';
            }
            else if(lstServ.size()>0 && lstServ[0].Operating_Company__r.Billing_Contact__r.Email_1__c != null){
                system.debug('SenderEmail'+lstServ[0].Operating_Company__r.Billing_Contact__r.Email_1__c);
                XMLString = XMLString+'<SenderEmail>'+lstServ[0].Operating_Company__r.Billing_Contact__r.Email_1__c+'</SenderEmail>';
            }
            else 
                XMLString = XMLString+'<SenderEmail>'+''+'</SenderEmail>';
            
            //RecipientEmail
            if(lstOrder[0].Account__c != null && lstOrder[0].Account__r.Billing_Email_Address__c != null ){
                system.debug('RecipientEmail'+lstOrder[0].Account__r.Billing_Email_Address__c);
                XMLString = XMLString+'<RecipientEmail>'+lstOrder[0].Account__r.Billing_Email_Address__c+'</RecipientEmail>';
            }
            else if(lstOrder[0].Contact__c != null && lstOrder[0].Contact__r.Email != null){
                system.debug('SenderEmail'+lstOrder[0].Contact__r.Email);
                XMLString = XMLString+'<RecipientEmail>'+lstOrder[0].Contact__r.Email+'</RecipientEmail>';
            }
            else 
                XMLString = XMLString+'<RecipientEmail>'+''+'</RecipientEmail>';
            //UserCredentialKey
            system.debug('UserCredentialKey'+lstOrder[0].Operating_Company__r.User_Credential_Key__c);
            if(lstOrder[0].Operating_Company__r.User_Credential_Key__c != null){
                system.debug('UserCredentialKey'+lstOrder[0].Operating_Company__r.User_Credential_Key__c);
                XMLString = XMLString+'<UserCredentialKey>'+lstOrder[0].Operating_Company__r.User_Credential_Key__c+'</UserCredentialKey>';
            }
            else{
                if(lstServ.size()>0 && lstServ[0].Operating_Company__r.User_Credential_Key__c != null){
                    system.debug('UserCredentialKey'+lstServ[0].Operating_Company__r.User_Credential_Key__c);
                    XMLString = XMLString+'<UserCredentialKey>'+lstServ[0].Operating_Company__r.User_Credential_Key__c+'</UserCredentialKey>';
                }
                else
                    XMLString = XMLString+'<UserCredentialKey>'+''+'</UserCredentialKey>';
            }
            //UserCredentialPassword
            system.debug('UserCredentialPassword'+lstOrder[0].Operating_Company__r.User_Credential_Password__c);
            if(lstOrder[0].Operating_Company__r.User_Credential_Password__c != null){
                system.debug('UserCredentialPassword'+lstOrder[0].Operating_Company__r.User_Credential_Password__c);
                XMLString = XMLString+'<UserCredentialPassword>'+lstOrder[0].Operating_Company__r.User_Credential_Password__c+'</UserCredentialPassword>';
            }
            else{
                if(lstServ.size()>0 && lstServ[0].Operating_Company__r.User_Credential_Password__c != null){
                    system.debug('UserCredentialPassword'+lstServ[0].Operating_Company__r.User_Credential_Password__c);
                    XMLString = XMLString+'<UserCredentialPassword>'+lstServ[0].Operating_Company__r.User_Credential_Password__c+'</UserCredentialPassword>';
                }
                else
                    XMLString = XMLString+'<UserCredentialPassword>'+''+'</UserCredentialPassword>';
            }
            //ClientDetailAccountNumber
            system.debug('ClientDetailAccountNumber'+lstOrder[0].Operating_Company__r.Client_Detail_Account_Number__c);
            if(lstOrder[0].Operating_Company__r.Client_Detail_Account_Number__c != null){
                system.debug('ClientDetailAccountNumber'+lstOrder[0].Operating_Company__r.Client_Detail_Account_Number__c);
                XMLString = XMLString+'<ClientDetailAccountNumber>'+lstOrder[0].Operating_Company__r.Client_Detail_Account_Number__c+'</ClientDetailAccountNumber>';
            }
            else{
                if(lstServ.size()>0 && lstServ[0].Operating_Company__r.Client_Detail_Account_Number__c != null){
                    system.debug('ClientDetailAccountNumber'+lstServ[0].Operating_Company__r.Client_Detail_Account_Number__c);
                    XMLString = XMLString+'<ClientDetailAccountNumber>'+lstServ[0].Operating_Company__r.Client_Detail_Account_Number__c+'</ClientDetailAccountNumber>';
                }
                else
                    XMLString = XMLString+'<ClientDetailAccountNumber>'+''+'</ClientDetailAccountNumber>';
            }
            //ClientDetailMeterNumber
            system.debug('ClientDetailMeterNumber'+lstOrder[0].Operating_Company__r.Client_Detail_Meter_Number__c);
            if(lstOrder[0].Operating_Company__r.Client_Detail_Meter_Number__c != null){
                system.debug('ClientDetailMeterNumber'+lstOrder[0].Operating_Company__r.Client_Detail_Meter_Number__c);
                XMLString = XMLString+'<ClientDetailMeterNumber>'+lstOrder[0].Operating_Company__r.Client_Detail_Meter_Number__c+'</ClientDetailMeterNumber>';
            }
            else{
                if(lstServ.size()>0 && lstServ[0].Operating_Company__r.Client_Detail_Meter_Number__c != null){
                    system.debug('ClientDetailMeterNumber'+lstServ[0].Operating_Company__r.Client_Detail_Meter_Number__c);
                    XMLString = XMLString+'<ClientDetailMeterNumber>'+lstServ[0].Operating_Company__r.Client_Detail_Meter_Number__c+'</ClientDetailMeterNumber>';
                }
                else
                    XMLString = XMLString+'<ClientDetailMeterNumber>'+''+'</ClientDetailMeterNumber>';
            }
            //PayorCountryCode
            system.debug('PayorCountryCode'+lstOrder[0].Operating_Company__r.Pay_Or_Country_Code__c);
            if(lstOrder[0].Operating_Company__r.Pay_Or_Country_Code__c != null){
                system.debug('PayorCountryCode'+lstOrder[0].Operating_Company__r.Pay_Or_Country_Code__c);
                XMLString = XMLString+'<PayorCountryCode>'+lstOrder[0].Operating_Company__r.Pay_Or_Country_Code__c+'</PayorCountryCode>';
            }
            else{
                if(lstServ.size()>0 && lstServ[0].Operating_Company__r.Pay_Or_Country_Code__c != null){
                    system.debug('PayorCountryCode'+lstServ[0].Operating_Company__r.Pay_Or_Country_Code__c);
                    XMLString = XMLString+'<PayorCountryCode>'+lstServ[0].Operating_Company__r.Pay_Or_Country_Code__c+'</PayorCountryCode>';
                }
                else
                    XMLString = XMLString+'<PayorCountryCode>'+''+'</PayorCountryCode>';
            }
            //Country
            system.debug('street order'+lstOrder[0].Warehouse__r.Country__c );
            if(lstOrder[0].Warehouse__r.Country__c != null){
                XMLString = XMLString+'<Country>'+lstOrder[0].Warehouse__r.Country__c+'</Country>';
            }
            else{
                system.debug('from country'+lstOrder[0].Operating_Company__r.Physical_Country__c);
                if(lstOrder[0].Operating_Company__r.Physical_Country__c != null){
                    system.debug('name'+lstOrder[0].Operating_Company__r.Physical_Country__c);
                    XMLString = XMLString+'<Country>'+lstOrder[0].Operating_Company__r.Physical_Country__c+'</Country>';
                }
                else{
                    if(lstServ.size()>0 && lstServ[0].Operating_Company__r.Physical_Country__c != null){
                        system.debug('name'+lstServ[0].Operating_Company__r.Physical_Country__c);
                        XMLString = XMLString+'<Country>'+lstServ[0].Operating_Company__r.Physical_Country__c+'</Country>';
                    }
                    else
                        XMLString = XMLString+'<Country>'+''+'</Country>';
                }
            }
            //Company
            if(lstOrder[0].Operating_Company__r.name != null){
                system.debug('name'+lstOrder[0].Operating_Company__r.name);
                XMLString = XMLString+'<Company>'+lstOrder[0].Operating_Company__r.name+'</Company>';
            }
            else{
                if(lstServ.size()>0 && lstServ[0].Operating_Company__r.name != null){
                    system.debug('name'+lstServ[0].Operating_Company__r.name);
                    XMLString = XMLString+'<Company>'+lstServ[0].Operating_Company__r.name+'</Company>';
                }
                else
                    XMLString = XMLString+'<Company>'+''+'</Company>';
            }
            //ContactName    
            if(lstOrder[0].Operating_Company__r.Billing_Contact__r.name != null){
                system.debug('name'+lstOrder[0].Operating_Company__r.Billing_Contact__r.name);
                XMLString = XMLString+'<ContactName>'+lstOrder[0].Operating_Company__r.Billing_Contact__r.name+'</ContactName>';
            }
            else{
                if(lstServ.size()>0 && lstServ[0].Operating_Company__r.Billing_Contact__r.name != null){
                    system.debug('name'+lstServ[0].Operating_Company__r.Billing_Contact__r.name);
                    XMLString = XMLString+'<ContactName>'+lstServ[0].Operating_Company__r.Billing_Contact__r.name+'</ContactName>';
                }
                else
                    XMLString = XMLString+'<ContactName>'+''+'</ContactName>';
            }
            //Address1
            system.debug('street order'+lstOrder[0].Warehouse__r.Address_1__c );
            if(lstOrder[0].Warehouse__r.Address_1__c != null){
                XMLString = XMLString+'<Address1>'+lstOrder[0].Warehouse__r.Address_1__c+'</Address1>';
            }
            else{
                if(lstOrder[0].Operating_Company__r.Physical_Street__c != null){
                    system.debug('street order'+lstOrder[0].Operating_Company__r.Physical_Street__c );
                    XMLString = XMLString+'<Address1>'+lstOrder[0].Operating_Company__r.Physical_Street__c+'</Address1>';
                }
                else{
                    if(lstServ.size()>0 && lstServ[0].Operating_Company__r.Physical_Street__c != null){
                        system.debug('street serv'+lstServ[0].Operating_Company__r.Physical_Street__c );
                        XMLString = XMLString+'<Address1>'+lstServ[0].Operating_Company__r.Physical_Street__c+'</Address1>';
                    }
                    else
                        XMLString = XMLString+'<Address1>'+''+'</Address1>';
                }
            }
            //Address2
            if(lstOrder[0].Operating_Company__r.Physical_Street2__c != null)
                XMLString = XMLString+'<Address2>'+lstOrder[0].Operating_Company__r.Physical_Street2__c+'</Address2>';
            else{
                if(lstServ.size()>0 && lstServ[0].Operating_Company__r.Physical_Street2__c != null)
                    XMLString = XMLString+'<Address2>'+lstServ[0].Operating_Company__r.Physical_Street2__c+'</Address2>';
                else
                    XMLString = XMLString+'<Address2>'+''+'</Address2>';
            }
            //DropoffType
            if(lstOrder[0].Operating_Company__r.Drop_off_Type__c != null){
                system.debug('DropoffType'+lstOrder[0].Operating_Company__r.Drop_off_Type__c );
                XMLString = XMLString+'<DropOffType>'+lstOrder[0].Operating_Company__r.Drop_off_Type__c+'</DropOffType>';
            }
            else{
                if(lstServ.size()>0 && lstServ[0].Operating_Company__r.Drop_off_Type__c != null){
                    system.debug('DropoffType serv'+lstServ[0].Operating_Company__r.Drop_off_Type__c );
                    XMLString = XMLString+'<DropOffType>'+lstServ[0].Operating_Company__r.Drop_off_Type__c+'</DropOffType>';
                }
                else
                    XMLString = XMLString+'<DropOffType>'+''+'</DropOffType>';
            }
            //ServiceType
            if(lstOrder[0].Operating_Company__r.Service_Type__c != null){
                system.debug('ServiceType'+lstOrder[0].Operating_Company__r.Service_Type__c );
                XMLString = XMLString+'<ServiceType>'+lstOrder[0].Operating_Company__r.Service_Type__c+'</ServiceType>';
            }
            else{
                if(lstServ.size()>0 && lstServ[0].Operating_Company__r.Service_Type__c != null){
                    system.debug('ServiceType serv'+lstServ[0].Operating_Company__r.Service_Type__c );
                    XMLString = XMLString+'<ServiceType>'+lstServ[0].Operating_Company__r.Service_Type__c+'</ServiceType>';
                }
                else
                    XMLString = XMLString+'<ServiceType>'+''+'</ServiceType>';
            }
            //City 
            system.debug('street order'+lstOrder[0].Warehouse__r.City__c );
            if(lstOrder[0].Warehouse__r.City__c != null){
                XMLString = XMLString+'<City>'+lstOrder[0].Warehouse__r.City__c+'</City>';
            }
            else{  
                if(lstOrder[0].Operating_Company__r.Physical_City__c != null)
                    XMLString = XMLString+'<City>'+lstOrder[0].Operating_Company__r.Physical_City__c+'</City>';
                else{
                    if(lstServ.size()>0 && lstServ[0].Operating_Company__r.Physical_City__c != null)
                        XMLString = XMLString+'<City>'+lstServ[0].Operating_Company__r.Physical_City__c+'</City>';
                    else
                        XMLString = XMLString+'<City>'+''+'</City>';
                }
            }
            //State
            system.debug('street order'+lstOrder[0].Warehouse__r.State__c );
            if(lstOrder[0].Warehouse__r.State__c != null){
                XMLString = XMLString+'<State>'+lstOrder[0].Warehouse__r.State__c+'</State>';
            }
            else{   
                if(lstOrder[0].Operating_Company__r.Physical_State__c != null)
                    XMLString = XMLString+'<State>'+lstOrder[0].Operating_Company__r.Physical_State__c+'</State>';
                else{
                    if(lstServ.size()>0 && lstServ[0].Operating_Company__r.Physical_State__c != null)
                        XMLString = XMLString+'<State>'+lstServ[0].Operating_Company__r.Physical_State__c+'</State>';
                    else
                        XMLString = XMLString+'<State>'+''+'</State>';
                }
            }
            //Signature    
            if(lstOrder[0].Operating_Company__r.Signature_Required__c != null)
                XMLString = XMLString+'<Signature>'+lstOrder[0].Operating_Company__r.Signature_Required__c+'</Signature>';
            else{
                if(lstServ.size()>0 && lstServ[0].Operating_Company__r.Signature_Required__c != null)
                    XMLString = XMLString+'<Signature>'+lstServ[0].Operating_Company__r.Signature_Required__c+'</Signature>';
                else
                    XMLString = XMLString+'<Signature>'+''+'</Signature>';
            }
            //Zip   
            system.debug('street order'+lstOrder[0].Warehouse__r.Zip__c );
            if(lstOrder[0].Warehouse__r.Zip__c != null){
                XMLString = XMLString+'<Zip>'+lstOrder[0].Warehouse__r.Zip__c+'</Zip>';
            }
            else{ 
                if(lstOrder[0].Operating_Company__r.Physical_Zip__c != null)
                    XMLString = XMLString+'<Zip>'+lstOrder[0].Operating_Company__r.Physical_Zip__c+'</Zip>';
                else{
                    if(lstServ.size()>0 && lstServ[0].Operating_Company__r.Physical_Zip__c != null)
                        XMLString = XMLString+'<Zip>'+lstServ[0].Operating_Company__r.Physical_Zip__c+'</Zip>';
                    else
                        XMLString = XMLString+'<Zip>'+''+'</Zip>';
                }
            }
            //Phone 
            system.debug('street order'+lstOrder[0].Warehouse__r.Phone__c );
            if(lstOrder[0].Warehouse__r.Phone__c != null){
                XMLString = XMLString+'<Phone>'+lstOrder[0].Warehouse__r.Phone__c+'</Phone>';
            }  
            else{
                if(lstOrder[0].Operating_Company__r.Main_Phone__c != null)
                    XMLString = XMLString+'<Phone>'+lstOrder[0].Operating_Company__r.Main_Phone__c+'</Phone>';
                else{
                    if(lstServ.size()>0 && lstServ[0].Operating_Company__r.Main_Phone__c != null)
                        XMLString = XMLString+'<Phone>'+lstServ[0].Operating_Company__r.Main_Phone__c+'</Phone>';
                    else
                        XMLString = XMLString+'<Phone>'+''+'</Phone>';
                }
            }
            //OrderName
            system.debug('order'+lstOrder[0].Name );
            if(lstOrder[0].Name != null){
                XMLString = XMLString+'<OrderName>'+lstOrder[0].Name+'</OrderName>';
            }
            //Ordername
            //Ext  
            XMLString = XMLString+'<Ext>'+''+'</Ext></FromAddress>';
                
                
            //XMLString = XMLString+'<Country>'+lstOrder[0].Account__r.ShippingCountry+'</Country><Company>'+''+'</Company><ContactName>'+lstOrder[0].Account__r.Name+'</ContactName><Address1>'+lstOrder[0].Account__r.ShippingStreet+'</Address1><Address2>'+''+'</Address2><City>'+lstOrder[0].Account__r.ShippingCity+'</City><State>'+lstOrder[0].Account__r.ShippingState+'</State><Zip>'+lstOrder[0].Account__r.ShippingPostalCode+'</Zip><Phone>'+lstOrder[0].Account__r.Phone+'</Phone><Ext>'+''+'</Ext></FromAddress>';
        }
    return XMLString;
    }//end of fromaddress xmlconstruction */
    
}//end of class