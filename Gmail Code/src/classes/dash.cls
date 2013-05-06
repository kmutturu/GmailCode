public class dash{
    
    PageReference strurl = new PageReference('/apex/vfdashboard');
    
    
    public PageReference getstrurl(){
        system.debug('tets'+strurl);
        return strurl;
    }
}