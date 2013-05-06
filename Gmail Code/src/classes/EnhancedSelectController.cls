public with sharing class EnhancedSelectController extends EnhancedComponentController{
	
	public String picklistEntries { get; set; }
	List<PicklistVal> picklistVals;
	List<SelectOption> picklistSO;
	String[] currVals = new List<String>();
	
	// because there is no true onload allowed for components
	// and the constructor is run before the setters on attributes
	public String getOnLoad(){
		  
		onLoad();
		  
		String currVal = (String) myValueHolder;		
		if(currVal != null)
			currVals = currVal.split(';', 0);	  				
		  
		  
		String updateHiddenField = 'function updateSL' + fieldName + '() { \n' + 
		'                $("#S' + fieldName + ' :hidden:input:first").val(""); \n' + 
		'                $("#SL' + fieldName + ' option:selected")' +
										  '.each(function(k,l) {\n' +
		'                var checkedVal = $(this).val();\n' + 
		'                var currValue = $("#S' + fieldName + ' :hidden:input:first").val();\n' +
		'                $("#S' + fieldName + ' :hidden:input:first").val(currValue + checkedVal + "");\n' +
		'                   } );\n' +
		'                 } \n';  

		String initialize = '$("#SL' + fieldName + '-button").remove(); \n' +   //if the element already exists remove it
		 '                 $("#SL' + fieldName + '").selectmenu()' +   
		 '                  .bind("change", function(){\n' + 
		'                   updateSL' + fieldName + '();\n' +
		'                }\n' + 
		'                );\n';


		/*
		String initialize = '$("#SL' + fieldName + '").selectmenu(' +   
		   '{\n' +
			'onChange: function(){\n' + 
			 'updateSL' + fieldName + '();\n' +
				 '}\n' + 
			' });\n'; */
		
		pageController.addJavascriptMethods(updateHiddenField);
		pageController.addOnLoadJavascript(initialize);
		return '';
	}
	
	  public List<PicklistVal> getPickListValues() {  
  
  		if(picklistSO == null && picklistEntries == null && myObject != null)  
  		{
	        Schema.sObjectType t = myObject.getSObjectType();
	        
	        Schema.DescribeSObjectResult objDesc = t.getDescribe();
	        Map<String, Schema.SObjectField> fieldsMap = objDesc.fields.getMap();
	        System.debug('fieldsMap:' + fieldsMap.size());
	        System.debug('fieldName:' + fieldName);
	        List<Schema.PicklistEntry> pickListValues = fieldsMap.get(fieldName).getDescribe().getPickListValues();
	        picklistSO = new List<SelectOption>();
	        for(Schema.PicklistEntry pe : pickListValues)
				picklistSO.add(new SelectOption(pe.getValue(), pe.getLabel()));
  		}
  		else if (picklistSO == null && picklistEntries != null)
  		{
				picklistSO = new List<SelectOption>();
				SelectOption so;
				so = new SelectOption('','--Select--');  
				picklistSO.add(so);  
					      
				String[] values = picklistEntries.split(',' , 0);
				for(String s:values) {
					so = new SelectOption(s,s);
					picklistSO.add(so);
				}
  			
  		} 
  		else if (picklistSO == null)
  			picklistSO = new List<SelectOption>();
  		
  			
		picklistVals = new List<PicklistVal>();
  		for(SelectOption so : picklistSO)
			picklistVals.add(new PicklistVal(so, currVals));
	        
        return picklistVals;
          
    }
    
	

}