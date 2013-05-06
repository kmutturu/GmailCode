public class ifelsecover{
    public void update1()
    {
        transient string editprof = 'fromtest';
        if(editprof!=null)
        {
                contact obj;
                obj = [select id from contact limit 1];      
                database.saveresult EditProfupdate = database.update(obj,false);
           // boolean blnflag = EditProfupdate.isSuccess();
                if(EditProfupdate.isSuccess())
                {
                    ApexPages.Message myMsg = new ApexPages.Message(ApexPages.Severity.fatal,'Profile Updated');
                    ApexPages.addMessage(myMsg);
                }
                else
                {
                    ApexPages.Message myMsg = new ApexPages.Message(ApexPages.Severity.fatal,'Profile is not Updated');
                    ApexPages.addMessage(myMsg);
            }
    }
    }
}