public class AdobeCustomTypes 
{
  public enum resultTypeEnum {ID, DOCUMENTKEY, URL, ERROR, WARNING, INFORMATION, SUCCESS}
  //Wrapper for the API/Methods responses
  public virtual class CommonResponse 
  { 
      public Boolean success { get; set; }  //Flag True for Success and False for failure
      public resultTypeEnum resultType { get; set; }   //Type of the result to be used for processing      
      public String resultMsg { get; set; } //Result message
  } 
}