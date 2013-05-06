/*
 * Salesforce Bot Header - Do not remove!
 *
 * $Author: Aslam Bari  $
 * $Change:  $
 * $DateTime: 08 Nov, 2009 $
 * $File: BotController.cls $
 * $Id:  $
 * $Revision:  1.0 $
 */

/*
 * This class will handle Bot Queries. Currently Supports only GET Method. You can pass queries and get instant result
 * from your GTalk Bot.
 * @author Aslam Bari
*/
public class BotController {
	public String outputData {get;set;}
	private Map<String,Map<String, Schema.SObjectField>> fieldMaps= new Map<String,Map<String, Schema.SObjectField>>();

/**
* Method : BotController
*
* Constructor
* */
	public BotController(){
		outputData = Utility.GetBrandHeader();
		try{
		String msg = ApexPages.currentPage().getParameters().get('msg');
		if(msg != null){
			msg = msg.toLowerCase();
			if(msg.startsWith('get')){
				Request req = parseRequest(msg);
				String query = Utility.getQuery(req);
				List<SObject> objects= Database.query(query);
				if(objects.size() > 0){
					Schema.SObjectType sObjType=objects[0].getSObjectType();
		    		Schema.DescribeSObjectResult descRes= sObjType.getDescribe();
		    		Map<String, Schema.SObjectField> fieldMap= descRes.fields.getMap();
					for(SObject obj: objects){
						for(String key: req.fields){
							if(key != null && key.trim().length() > 0){
		    					getFieldData(obj,key.trim(),fieldMap);
							}
						}
						outputData = outputData.substring(0,outputData.length() - 2);
						outputData += '<br/>'; 
		            }
				}
			}  
		}
		}catch(Exception ex){
			outputData += 'Wrong Bot Query Syntax. Contact aslam.bari@gmail';
		}
		
		outputData += Utility.GetBrandFooter();
	}

/**
* Method : parseRequest
*
* @param query String
* */
	private Request parseRequest(String query){
		query = query.trim();
		query = query.replace('*','%');
		List<String> tokens = query.split(' ');
		String method = '';
		Integer index = 0;
		for(Integer i = index; i < tokens.size();i++){
			if(tokens[i].trim().length() > 0){
				method = tokens[i].trim();
				index = i;
				break;
			}
		}
		
		String table = '';
		for(Integer i = index + 1; i < tokens.size();i++){
			if(tokens[i].trim().length() > 0){
				table = tokens[i].trim();
				index = i;
				break;
			}
		}
		
		String startField = '';
		for(Integer i = index + 1; i < tokens.size();i++){
			if(tokens[i].trim().length() > 0){
				startField = tokens[i].trim();
				break;
			}
		}
		
		
		Integer iStart = query.indexOf(startField);
		Integer iEnd = query.indexOf(' [');
		String fields = '';
		if(iEnd < 0){
			fields = query.substring(iStart);
		}else{
			fields = query.substring(iStart, iEnd);
		}
		
		String criteria = null;
		if(query.contains(' [')){
			Integer startBracket = query.indexOf(' [');
			Integer endBracket = query.indexOf(']');
			criteria = query.substring(startBracket + 2, endBracket);
		}
		
		List<String> lstFields = Utility.split(fields,',');
		
		Request req = new Request();
		req.method = method;
		req.table = table;
		req.fields = lstFields;
		req.criteria = criteria;
		
		return req;
		
	}
/**
* Method : getFieldData
*
* @param object SObject
* @param key String
* @param object SObject
* @param fieldMap Map<String, Schema.SObjectField>*/
	private void getFieldData(SObject sfObject, String key, Map<String, Schema.SObjectField> fieldMap){
    	if(key.indexOf('.') < 0){    		
			outputData = outputData + (sfObject.get(fieldMap.get(key))==null ? '&nbsp' : sfObject.get(fieldMap.get(key))) + ', ';
			return;    		
    	}
    	
    	String objectKey =key.subString(0,key.indexOf('.')).trim();
    	String subjectKey =key.subString(key.indexOf('.')+1).trim();
		
		SObject childData = sfObject.getSObject(objectKey);
				
		if(fieldMaps.containsKey(key)){
			fieldMap=fieldMaps.get(key);
		}
		else{
			if(childData != null){
				Schema.SObjectType sObjType=childData.getSObjectType();
				Schema.DescribeSObjectResult descRes= sObjType.getDescribe();
				fieldMap= descRes.fields.getMap();
				fieldMaps.put(key,fieldMap);
			}
		}
				
		if(childData != null)	{
			getFieldData(childData, subjectKey, fieldMap);
			
		}
		else{
			outputData = outputData;
			return;
		}
		
	
    }
}