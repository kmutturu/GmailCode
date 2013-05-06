public class actionfun{

    public pagereference call(){
        Contact obj = new contact();
        obj.lastname = 'new *****   Record for Action Function';
        insert obj;
        pagereference pg = new pagereference('https://ap1.salesforce.com/'+obj.id);
        return pg;
    }

}