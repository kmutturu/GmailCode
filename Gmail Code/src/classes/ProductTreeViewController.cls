public with sharing class ProductTreeViewController {
    public list<selectOption> options = new list<selectOption>(); // list to hold Pricebook options
    public list<PricebookEntry> Products = new list<PricebookEntry>();
    private Id PricebookId;


    public ProductTreeViewController(){
        this.PricebookId = getPricebookId();
        //this.Products = getProducts();
    }


    public list<PricebookEntry> getProducts(){
        list<PricebookEntry> Products = [select Pricebook2Id, Id, ProductCode, Name, Product2.Family 
                     from PricebookEntry
                    where IsActive = true and Pricebook2Id = :PricebookId limit 10];

        system.debug('----------------------- PricebookId: ' + PricebookId);
        system.debug('----------------------- this.PricebookId: ' + this.PricebookId);
        system.debug('----------------------- Products: ' + Products);
        return Products;
    }


    public Id getPricebookId(){
        if(PricebookId==null) PricebookId='01s4000000024pn';
        return PricebookId;
    }


    public void setPricebookId(Id PricebookId){
        this.PricebookId = PricebookId;
    }


    public PageReference refreshProducts(){
        system.debug('----------------------- xPricebookId: ' + PricebookId);
        system.debug('----------------------- xthis.PricebookId: ' + this.PricebookId);
        system.debug('----------------------- xProducts: ' + Products);
        return null;
    }


    public List<selectOption> getpb() {
        list<selectOption> options = new list<selectOption>(); //new list for holding all of the picklist options
        for (Pricebook2 pb2 : [select Id, Name from Pricebook2 where IsActive = true]) {
            options.add(new selectOption(pb2.Id, pb2.Name));
        }
        return options;
    }
}