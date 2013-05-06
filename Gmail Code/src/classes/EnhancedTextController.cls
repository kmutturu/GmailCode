public with sharing class EnhancedTextController extends EnhancedComponentController {

	public String validateAs	 { get; set; }
	public String maxLength 	 { get; set; }
	private List<String> frontBack;
	
	// because there is no true onload allowed for components
	// and the constructor is run before the setters on attributes
	public String getOnLoad(){
		
		  
		  onLoad();  
		  System.debug('getOnLoad TEXT');
		  
		  String s = (String) myValueHolder;
		  System.debug('val: ' + s );
		  if (s != null) {
				// split only works some of the time
				// see: http://community.salesforce.com/t5/Apex-Code-Development/String-split-method-works-only-some-of-the-time/m-p/185684#M30085 
				//  frontBack = s.split('.');
				try{
					  Integer i = s.indexOf('.');
					  System.debug(i + ' index of period');
					  frontBack = new List<String>();
					  frontBack.add(s.substring(0,i));
					  frontBack.add(s.substring(i+1,s.length()));
				}
				catch(Exception e)
				{
					
				}
								
			  System.debug('FB:' + frontBack.size());
			  if(frontBack.size() > 1)
			  {
		  		System.debug('WOO I made it');
		  		System.debug(frontBack[0]);  
		  		System.debug(frontBack[1]);
		  		System.debug(frontBack[1].length());
		  			  		
			  	frontBack[1] = frontBack[1].replace('0','');
		  		System.debug(frontBack[1]);
		  		System.debug(frontBack[1].length());
			  	
			  	if(frontBack[1].length() == 0) {
		  			System.debug('WOO I made it2');
			  		myValueHolder = frontBack[0];
			  		System.debug('New MVH: ' + (String) myValueHolder);	
			  	}  
			  }
		  }
		  
		  Boolean valRuleAdded = false;  
		  String validationString = '';
		  if(validateAs != null)
		  {
	          if (validateAs.toUpperCase() == 'URL') 
	          {
	          	validationString += 'url: true, maxlength: 255';
	          	valRuleAdded = true;
	          }   
	          else if (validateAs.toUpperCase() == 'NUMBER') 
	          {
	          	validationString += 'number: true';
	          	valRuleAdded = true;
	          }   
	          else if (validateAs.toUpperCase() == 'EMAIL') 
	          {
	          	validationString += 'email: true';
	          	valRuleAdded = true;
	          }   
	          else if (validateAs.toUpperCase() == 'PHONEUS') 
	          {
	          	validationString += 'phone: true';
	          	valRuleAdded = true;
	          }
	          else if (validateAs.toUpperCase() == 'CURRENCY') 
	          {
	          	validationString += 'currency: true';
	          	valRuleAdded = true;
	          }
	          else if (validateAs.toUpperCase() == 'PERCENT' || validateAs.toUpperCase() == 'PERCENTAGe') 
	          {
	          	validationString += 'percentage: true';
	          	valRuleAdded = true;
	          }
	          
	          else if (validateAs.toUpperCase() == 'INTERNATIONALPHONE') 
	          {
	          	validationString += 'internationalPhone: true';
	          	valRuleAdded = true;
	          }
	          else if (validateAs.toUpperCase() == 'NAME') 
	          {
	          	validationString += 'allCapsDisallowed: true,\n' +
	          						'allLowercaseDisallowed: true,\n' +
	          						'ASCIIOnly: true\n';  
	          	valRuleAdded = true;
	          }
	          
		  }  
	                                     
           if(maxLength != null) {
           		if(valRuleAdded)
           			validationString += ', ';
           		else
           		  valRuleAdded = true;
           		validationString += 'maxlength: ' + maxlength; 
           }
		if(validationString != '')
		{
			String initialize = '$(".T' + fieldName + '").rules("add", \n' +   
										' { ' + validationString + ' });\n';  
			
			pageController.addOnLoadJavascript(initialize);
		}
		return '';
	}
	
	
	public override Object getCastedValue()      
	{	
			  String mvhs = (String) myValueHolder;
			  if(myValueHolder == null || mvhs.length() == 0)
			  	return null;
			  	
	 		  String myType;
			  if(validateAs != null)
			  	 myType = validateAs.toUpperCase();
	          
	          if (myType == 'NUMBER' || myType == 'PERCENT' || myType == 'PERCENTAGE')   
	          {
	          	mvhs = mvhs.replaceAll('%','');
				Double d = Double.valueOf(mvhs);  
				return d;     
	          }   
	          else if (myType == 'CURRENCY')     
	          {
	          	Decimal myDecimal = Decimal.valueOf((String) myValueHolder);
	          	return myDecimal;
	          }   
	          else
	          	return myValueHolder;
	          
	}
	
}