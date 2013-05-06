public with sharing class EnhancedMultiselectController extends EnhancedComponentController{
	
	public String picklistEntries	{ get; set; }
	List<PicklistVal> picklistVals;  
	List<SelectOption> picklistSO;
	String[] currVals = new List<String>();
	
	// because there is no true onload allowed for components
	// and the constructor is run before the setters on attributes
	public String getOnLoad() {

		onLoad();
		
		String currVal = (String) myValueHolder;		
		if(currVal != null)
			currVals = currVal.split(';', 0);	  				
		      
		String updateHiddenField = '' + 
		'          function updateMS' + fieldName + '() { \n' + 
		'                $("#S' + fieldName + ' :hidden:input:first").val(""); \n' + 
		'                $("input[name=\'MS' + fieldName + '\']:checked")' +
		                      '.each(function(k,l) {\n' +
		'                          var checkedVal = $(this).val();\n' + 
		'                          var currValue = $("#S' + fieldName + ' :hidden:input:first").val();\n' +
		'                          $("#S' + fieldName + ' :hidden:input:first").val(currValue + checkedVal + ";");\n' +
		'                      } );\n' +
		'                  } \n';
						
		String initialize = '' +
		//'      $('.ui-multiselect-checkboxes > li > label > a > input').each(function() { appendTo($(this).parent.parent()); } );
		
		//find('a span div').remove()\n' +		

		//'      $('.ui-multiselect-checkboxes > li > label').find('a span div').remove()\n' +		
		//'       $(".ui-multiselect-options").empty().remove();\n' +		
		'       $("[name=\'MS' + fieldName + '\'].ui-multiselect").remove();\n' +
		'       $("[name=\'MS' + fieldName + '\']").multiSelect({\n' +
		'         onCheck: function(){\n' + 
		'           updateMS' + fieldName + '();\n' +
		'          },\n' + 
		'         onUncheckAll: function(){\n' + 
	 	'             $("#S' + fieldName + ' :hidden:input:first").val(""); \n' + 
		'         },\n' + 
		'         onCheckAll: function(){\n' + 
		'            updateMS' + fieldName + '();\n' +
		'            }\n' +     
		'         });\n';
			
		
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