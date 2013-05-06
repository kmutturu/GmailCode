public class add{

    public integer a {get;set;}
    
        public integer b {get;set;}


    public pagereference result(){
            
           pagereference pf = new pagereference('/apex/second2?val='+(a+b));
           pf.setredirect(true);
           return pf;
            
    }
    
    
    string str = 'Hi con 1'+'\n'+'Please see attached invoice for work completed atBoathouse 1'+'\n'+
    'Payment is due upon receiving the invoice.If you require anything else in the future please do not hesitate to get in touch.'+'\n'+
    'Thanks for choosing Product!'+'\n'+'Cheers,Product Pressure Washing.'+'\n'+'1-855-UR-HEROES www.Product.ca'+'\n'+
    '"YourProperty Services Superheroes'+'\n'+'" Service - Pride - Growth - Team Work';


public string getval(){return str;}

}