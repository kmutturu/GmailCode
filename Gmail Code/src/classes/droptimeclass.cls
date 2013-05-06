public class droptimeclass{

    public droptimeclass(){
    
        tcurrenttime = system.now().time();
    }


      public List<SelectOption> getItems() {
        List<SelectOption> options = new List<SelectOption>();
        options.add(new SelectOption(string.valueOf(system.now().time()),string.valueOf(system.now().time())));
        options.add(new SelectOption(string.valueOf(system.now().time().addMinutes(-30)),string.valueOf(system.now().time().addMinutes(-30))));
         options.add(new SelectOption(string.valueOf(system.now().time().addHours(-1)),string.valueOf(system.now().time().addHours(-1))));
          options.add(new SelectOption(string.valueOf(system.now().time().addHours(-2)),string.valueOf(system.now().time().addHours(-2))));       
        return options;
    }    


    public time tcurrenttime{get;set;}
        public time tcurrenttime1{get;set;}
            public time tcurrenttime2{get;set;}
                public time tcurrenttime3{get;set;}


}