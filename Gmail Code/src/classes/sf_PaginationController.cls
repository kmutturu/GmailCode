/*
        Name           : sf_PaginationController
        Author         : iBirds Software Services
        Date           : 17th July 2012
        Description    : Pagination on Contact
*/

public class sf_PaginationController{
    // initial query string for contact
    String queryString = 'Select Id,FirstName,LastName,Email,Account.Name from Contact';
    
    Integer queryLimit;
    Integer offset;
    
    // for active and deactive page naviagator
    public Boolean firstOff{set;get;}    // previous part
    public Boolean lastOff{set;get;}     // next part
    
    public String limits{set;get;}
    public Integer pageNumber{set;get;}
    
    Integer listSize;    // for total contact size
    
    // constructor
    public sf_PaginationController(){
        firstOff = false;
        queryLimit = 10;
        offset = 0;
        limits = '10';
        pageNumber = 1;
        
        aggregateResult res = [select COUNT(id) cnt from Contact ];
        
        // fill size of all contact
        listSize = Integer.valueOf(res.get('cnt'));
        
        // initialy check page more then 1 or not
        if(listSize > queryLimit) lastOff = true;
        else lastOff = false;
    }
    
    // get record according to limit and offset
    public List<Contact> getRecords(){
       return (List<Contact>)database.query(queryString+' LIMIT '+queryLimit+' OFFSET '+offset);
    }
    
    // navigate on next page
    public void next(){
        offset += queryLimit;
        if(offset+queryLimit >= listSize) lastOff = false;
        firstOff = true;
        pageNumber++;
    }
    
    // navigate on previous page
    public void previous(){
        if(offset-queryLimit <= 0){
            offset = 0;
            firstOff = false;
        }
        else offset -= queryLimit;
        lastOff = true;
        pageNumber--;
    }
    
    // switch on first page
    public void first(){
        offset = 0;
        firstOff = false;
        lastOff = true;
        
        pageNumber = 1;
    }
    
    // switch on last page
    public void last(){
        // set page number of and offset
        if(Math.Mod(listSize,queryLimit) == 0){
            offset = listSize-queryLimit;
            pageNumber = listSize/queryLimit;
        }
        else{
            offset = (listSize/queryLimit)*queryLimit;
            pageNumber = (listSize/queryLimit)+1;
        }
        
        lastOff = false;
        firstOff = true;
    }
    
    // for record limits
    public List<SelectOption> getItems(){
        List<SelectOption> options = new List<SelectOption>();
        options.add(new SelectOption('10','10'));
        options.add(new SelectOption('20','20'));
        options.add(new SelectOption('50','50'));
        options.add(new SelectOption('100','100'));
        return options;
    }
    
    // change query limit
    public void changeLimit(){
        // set query limit
        queryLimit = Integer.valueOf(limits);
        
        offset = 0;
        firstOff = false;
        
        // initialy check page more then 1 or not
        if(listSize > queryLimit) lastOff = true;
        else lastOff = false;
        
        // set page number
        pageNumber = 1;
    }
    
    // for show current record numbers
    public String getRecordInfo(){
        integer lastLimit;
        if(offset+queryLimit > listSize) lastLimit = listSize;
        else lastLimit = offset+queryLimit;
        return (offset+1) + ' - ' + lastLimit + ' of '+listSize;
    }
    
    // return total page number
    public Integer getTotalPage(){
        if(Math.Mod(listSize,queryLimit) == 0) return listSize/queryLimit;
        else return (listSize/queryLimit)+1;
    }
    
    // for direct page switching
    public void pageNavigation(){
    
        /* if user enter more then number ot total page number than
           set the value last page number in PageNumber. */
        if(Math.Mod(listSize,queryLimit) == 0 && pageNumber > listSize/queryLimit)
            pageNumber = listSize/queryLimit;    
        else if(pageNumber > (listSize/queryLimit)+1)
            pageNumber = (listSize/queryLimit)+1;
        
        // set offset according to pageNumber    
        if((pageNumber-1)*queryLimit < 0) offset = 0;
        else offset = (pageNumber-1)*queryLimit;    
        
        /* if pageNumber is 1 than deactive previous navigator
           else if pageNumber is o tha set the value of pageNumber is 1
           else if pageNumber is more than 1 active next navigator
        */
        if(pageNumber == 1) firstOff = false;
        else if(pageNumber == 0) pageNumber = 1;
        else if(pageNumber > 1) firstOff = true;
        
        // user enter last number of pagenumber than deactive next navigator
        if(Math.Mod(listSize,queryLimit) == 0){
            if(pageNumber == listSize/queryLimit) lastOff = false;
            else lastOff = true;
        }
        else{
            if(pageNumber == (listSize/queryLimit)+1) lastOff = false;
            else lastOff = true;
        }
    }
}