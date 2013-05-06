public class quoteExt {

    ApexPages.StandardController controller;

    public Quote q {get;set;}

    public quoteExt (ApexPages.StandardController c) {
        controller = c;
        q          = (Quote) c.getRecord();

    }

public PageReference attachQuote() {

        PageReference pdfPage;

        Quote quote = [select id from Quote 
                where id = :ApexPages.currentPage().getParameters().get('id') ];
   
        
         
        //pdfPage.getParameters().put('id',q.id);
        
        Blob pdfBlob = pdfPage.getContentAsPDF();
        
        QuoteDocument a = new QuoteDocument(quoteId= q.id, Document = pdfBlob);
        
        insert a;
        
        return controller.view();
    }
}