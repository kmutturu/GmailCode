public class actionpol{
   
   
    public pagereference call(){
        contact obj = new contact();
           obj.lastname = 'test action function';
           insert obj;
           
         pagereference pg = new pagereference('https://ap1.salesforce.com/'+obj.id);
        return pg;
    }
    
   
}