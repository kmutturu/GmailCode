public with sharing class EnhancedCheckboxController extends EnhancedComponentController{
	
	public String getOnLoad(){
		
		onLoad();
										  					
		return '';
	}
	
	
	/*public override Object getCastedValue() {     

  	  try
  	  {
  	  	Boolean bvh = (Boolean) myValueHolder;
	  	return bvh;
  	  }
  	  catch(Exception e)
  	  {
  	  	System.debug('Cannot cast to Boolean:' + e);
  	  	return false;
  	  }
	  
	}*/
	  
	

}