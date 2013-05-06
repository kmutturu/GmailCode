/*
 * Salesforce Bot Header - Do not remove!
 *
 * $Author: Aslam Bari  $
 * $Change:  $
 * $DateTime: 08 Nov, 2009 $
 * $File: Utility.cls $
 * $Id:  $
 * $Revision:  1.0 $
 */

/*
 * This class contains utility functions for doing misc tasks.
 * @author Aslam Bari
*/
public class Utility {

/**
* Method : split
*
* @param strArg String
* @param separator String*/
public static List<String> split(String strArg, String separator){
	List<String> lstArray = strArg.trim().split(separator);
	return lstArray;
}
	
/**
* Method : join
*
* @param lstArray List<String>
* @param separator String*/
public static String join(List<String> lstArray, String separator){
	String joinedStr = '';
	for(String str: lstArray){
		joinedStr += str + ',';
	}
	if(joinedStr.length() > 0){
		joinedStr = joinedStr.substring(0,joinedStr.length() - 1);
	}
	
	return joinedStr;
}

/**
* Method : getQuery
*
* @param req Request*/
public static String getQuery(Request req){
	String query = '';
	if(req.method.equalsIgnoreCase('GET')){
		query += 'SELECT';
	}
	query += ' ' + Utility.join(req.fields, ',');		
	query += ' FROM ' + req.table;
	
	
	if(req.criteria != null){
		query += ' WHERE ' + req.criteria;
	}
	
	query += ' ORDER BY LASTMODIFIEDDATE DESC LIMIT 10 ';
	return query;
}

/**
* Method : GetBrandHeader
*
**/
public static String GetBrandHeader(){
	String brand = 'Salesforce Bot';
	brand += '<br/>------------------------------------------------------------<br/>';
	return brand;
}
	
/**
* Method : GetBrandHeader
*
**/
public static String GetBrandFooter(){
	String brand = '<br/>------------------------------------------------------------<br/>';
	brand += 'aslam.bari@gmail.com';
	return brand;
}
}