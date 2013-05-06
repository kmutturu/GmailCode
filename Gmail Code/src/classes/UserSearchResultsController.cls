public class UserSearchResultsController{
    private String txtFirstName;
    private String txtLastName;
    private String queryStr;
    private Id userid;
    public List<User> users;
    public boolean Isrendered {get;Set;}   
    public ID seluser{get;set;}
    public PageReference init(){
        txtFirstName = ApexPages.currentPage().getParameters().get('userfirstname');
        txtLastName = ApexPages.currentPage().getParameters().get('userlastname');
        seluser=ApexPages.currentPage().getParameters().get('id');
        userid = Userinfo.getUserId();
        queryStr = '';
        Isrendered = true;
        return null;
    }
   
    public PageReference doSearch(){
       
        txtFirstName = this.userfirstname;
        txtLastName = this.userlastname;
        system.debug('FirstName:'+txtFirstName);
        userid = Userinfo.getUserId();
        queryStr = '';
        Isrendered = true;
        //**** We can't include % in the URL
        if(txtFirstName.contains('%'))
        {      
        txtFirstName=txtFirstName.replace('%','');
        }
        if(txtLastName.contains('%'))
        {      
        txtLastName=txtLastName.replace('%','');
        }
 
        PageReference Newpage = new PageReference('/apex/SearchWaterCMSUsers?userfirstname=' + txtFirstName + '&userlastname=' + txtLastName);
        Newpage.setRedirect(true);
        return Newpage;
       
    }
 public PageReference Search(){
 
        txtFirstName = this.userfirstname;
        txtLastName = this.userlastname;
        system.debug('FirstName:'+txtFirstName);
        userid = Userinfo.getUserId();
        queryStr = '';
        Isrendered = true;
        //**** We can't include % in the URL
        if(txtFirstName.contains('%'))
        {      
        txtFirstName=txtFirstName.replace('%','');
        }
        if(txtLastName.contains('%'))
        {      
        txtLastName=txtLastName.replace('%','');
        }
 
        PageReference Newpage = new PageReference('/apex/changemanager?userfirstname=' + txtFirstName + '&userlastname=' + txtLastName+'&id='+seluser);
        Newpage.setRedirect(true);
        return Newpage;
       
    }
 
   
    public String userfirstname{
        get{return txtFirstName;}
        set{this.txtFirstName = value;}
    }
   
    public String userlastname{
        get{return this.txtLastName;}
        set{this.txtLastName = value;}
    }
   
 
  
    public List<User> getalluserssvisible(){
        String q = this.getqueryStringUser();
      //system.debug('Length:'+q.length());
        if(q != ''){          
            users = database.query(q);
            return users;   
        } else {
            return null;
        }
    }
   
    private String getqueryStringUser(){
        try
        {
        if(txtFirstName !=null){
            queryStr = 'select id, name,firstname,lastname,email from User u where u.Profile.Name = \'GE_PW WCMS Sales\'';
                   if(txtFirstName.length() > 0) queryStr = queryStr + ' and firstname like \''+txtFirstName+'%\'';
                   if(txtLastName.length() > 0) queryStr = queryStr + ' and lastname like \''+txtLastName+'%\'';
            queryStr = queryStr + ' order by firstname';
            queryStr = queryStr + ' limit 25';
            system.debug('Query String:'+queryStr);}
         else
         { queryStr=''; }
         return queryStr;
        }
        catch (Exception e)
        {
                   return null;
        }   
    }
 
}