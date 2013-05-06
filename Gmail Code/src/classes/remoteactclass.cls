public global class remoteactclass{

    

    @remoteaction
    global static account acctval(string actname){
        system.debug('********'+actname);
        if(actname != ''){
            account act = [select id,phone from account where name = :actname];
            return act;
        }
        return null;
    }
    
}