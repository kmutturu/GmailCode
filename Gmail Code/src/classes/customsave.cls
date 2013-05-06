public with sharing class customsave {

public string strname{get;set;}


public pagereference save(){

pagereference pg = new pagereference('/001/e');
pg.setredirect(true);

return pg;

}




}