public with sharing class convertintoPDF {

    public account objAct;

    public convertintoPDF(ApexPages.StandardController controller) {
        objAct = (account)controller.getRecord(); 
    }
    
    public pagereference getpdf(){
    
      pagereference pg = new pagereference('/apex/customm');
      
      blob b = pg.getContentAsPDF();
      
     Attachment obj = new Attachment();
      obj.Body = b;
      obj.Name = String.valueOf('test.txt');
      obj.ParentId = objAct.id; 
      insert obj;
      
      
      return (new pagereference('/servlet/servlet.FileDownload?file='+obj.id));
    
    
    }

}