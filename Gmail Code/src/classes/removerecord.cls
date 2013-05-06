public class removerecord{
    public ID userid;
    public string UserList{get;set;}
    public string SelId;
    Public List<String> priID_SecIDStr = new List<String>();
      Public List<ID> IdSel = new List<ID>();
    public GE_PW_User_Sales_Hierarchy_Association__c pri = new GE_PW_User_Sales_Hierarchy_Association__c();
    public List<GE_PW_User_Sales_Hierarchy_Association__c> sec = new List<GE_PW_User_Sales_Hierarchy_Association__c>();
    public removerecord()
    {
        UserList = ApexPages.currentpage().getParameters().get('id');
        SelId = System.currentPageReference().getParameters().get('loc'); 
 
   }
  
   Public pageReference RemoveLocationIDs()
   {
      
       //**** Check for the split size
         if(SelId.split(',').size() == 1)
          {
          ID LocID = SelId;
          pri=[Select ID from GE_PW_User_Sales_Hierarchy_Association__c where id =:LocID];
          Delete pri;   
          }  
         else 
          {
          priID_SecIDStr = SelId.split(',');
                 for(String s : priID_SecIDstr )
            {
           ID spliID = s;
           IdSel.add(spliID);
           sec=[Select ID from GE_PW_User_Sales_Hierarchy_Association__c where id IN:IdSel];    
           Delete sec;
            }
          }
       PageReference NewPage=new PageReference('/apex/ManageLocationid?id='+UserList);
       NewPage.setRedirect(true);
       return NewPage;
           
     }
}