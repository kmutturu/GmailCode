public with sharing class EnhancedLookupController extends EnhancedComponentController {
	
	public String displayColumn 	{ get; set; }
	public String objectToLookup 	{ get; set; }
	public String displayName 		{ get; set; }
	private String jsonData;
	
	public String getOnLoad(){

		onLoad();

		if (displayColumn == null)
			displayColumn = 'name';
			
		String jsonData = getJson();
						  						
		String initialize = 'var l' + fieldName + 'data = ' + jsonData + ';\n' +
							
							'$(".L' + fieldName + '").autocomplete(l' + fieldName + 'data, { \n' +
							'\n' + 			
							'						 formatItem: function(item) {  \n' +
							'						   return item.'+ displayColumn + ';      \n' +
							'						   }   \n' +
							'\n' +
							'						 }).result(function(event, item) {\n' +
							'								  $(".S' + fieldName + ' :input:hidden:first").val(item.id);\n' +
							'								});  \n';
  
		

		pageController.addOnLoadJavascript(initialize);
		return '';
		
	}

    // see: http://community.salesforce.com/t5/Apex-Code-Development/Building-a-reusable-JSON-component/m-p/172428
    // and: http://joe-ferraro.com/2009/04/extjs-vf-json/
    
    public String getJson()
     {
     	if (jsonData == null) 
     	{

	     	jsonData = '';
			try {
				System.debug('getJsonifiedObjectRecords for:' + fieldname + ' ' + objectToLookup );
				  
				List<String> columns = new List<String>();
				  
				columns.add('id');
				if(displayColumn != null)
					columns.add(displayColumn);
				else
					columns.add('name');   
				  
				String queryString = 'Select id, ' + displayColumn + ' from ' + objectToLookup + ' limit 1000';
				System.debug('queryString:' + queryString);
				List<sObject> sos = Database.query(queryString);
				//Map<String, Schema.SObjectField> columns = sos.getSObjectType().getDescribe().fields.getMap();
									  
				jsonData += '[';    
		        for (sObject so : sos) {  
		        		jsonData += ' { ';
						  for(String column : columns)
				          {   
				          			//System.debug('jsonData:' + jsonData);
				                     try 
				                     {
				                     	String cellVal = String.valueOf( so.get(column));
				                        jsonData += ''+column+': "'+cellVal+'",';
				                        if (cellVal == (String) myValueHolder)
				                        	displayName = cellVal;   
				                     }   
				                     catch(Exception ex) 
				                     {
										System.debug(ex);
				                     }
						 }
			 			 jsonData = jsonData.substring(0, jsonData.length() - 1);
	                	 jsonData = jsonData + '},';  
						 
		        }
		
				jsonData = jsonData.subString(0,jsonData.length() - 1);
		        jsonData = jsonData + ']';
				
	        }
			catch(Exception e)
			{	
				System.debug('Bad query in Jsonify Call ' + e);			
			}
     }
     	
      	System.debug('jsonData:' + jsonData);
        return jsonData;
      	}
      	

	

}