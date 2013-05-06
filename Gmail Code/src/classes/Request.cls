/*
 * Salesforce Bot Header - Do not remove!
 *
 * $Author: Aslam Bari  $
 * $Change:  $
 * $DateTime: 08 Nov, 2009 $
 * $File: Request.cls $
 * $Id:  $
 * $Revision:  1.0 $
 */

/*
 * This class has a Simple Data model for Each Request. Currently supports only GET method.
 * @author Aslam Bari
*/
public class Request{
	public string method {get;set;}
	public string table {get;set;}
	public List<String> fields {get;set;}
	public string criteria {get;set;} 
}