@isTest
private class testmyclass{
    static testmethod void mytestname(){
        theController  obj = new theController();
        obj.getSearchText();
        obj.setSearchText('test');
        obj.getResults();
        obj.doSearch();
    }
}