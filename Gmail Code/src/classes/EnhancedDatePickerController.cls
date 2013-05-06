public with sharing class EnhancedDatePickerController extends EnhancedComponentController{
	
	
	public override void onLoad() {
		
		try {      
	  		System.debug('onLoad ' + fieldName);
		  	myObject = pageController.myObject;
		  	if(myObject != null && myObject.get(fieldName) != null) {
		  		Date d = (Date) myObject.get(fieldName);
        		Datetime dt = Datetime.newInstance(d.year(),d.month(),d.day());
        		System.debug('DATETIME:' + d.year() + ' - ' + d.month() + ' - ' + d.day() );
		  		myValueHolder = dt.format('M/d/yyyy');
		  	}
			String s = (String) myValueHolder;
			System.debug('onLoad Value: ' + s);
	  	}
	  	catch(SObjectException soe)
	  	{
	  		System.debug(soe);
	  	}    
		
	}

	
	// because there is no true onload allowed for components
	// and the constructor is run before the setters on attributes
	public String getOnLoad(){
		
		onLoad();
										  					
		String initialize = '$(".DP' + fieldName + '").datepicker({ changeYear: true, ' +
																	'changeMonth: true });\n';
																			
		pageController.addOnLoadJavascript(initialize);
		return '';
	}
	
	// supports two formats, 'yyyy-MM-dd' and 'mm/dd/yyyy'
	
	public override Object getCastedValue() {     

  	  String s = (String) myValueHolder;
  	  
  	  if(s != null)
  	  {
		  String[] stringDate = s.split('/');
	  	  if(stringDate.size() == 3)
	  	  {
		      Integer m = Integer.valueOf(stringDate[0]);
		      Integer d =  Integer.valueOf(stringDate[1]);
		      Integer y = Integer.valueOf(stringDate[2]);
			  return date.newInstance(y,m,d);
	  	  }
	  	  else
	  	  {
	  	  	stringDate = s.split('-');
	  	  	if(stringDate.size() == 3)
	  	  	{
	  	  	  Integer m = Integer.valueOf(stringDate[1]);
		      Integer d =  Integer.valueOf(stringDate[2].split(' ')[0]);
		      Integer y = Integer.valueOf(stringDate[0]);
			  return date.newInstance(y,m,d);
	  	  	}
	  	  }
  	  
  	  }  
  	  
	   return null;

	}
	  
	

}