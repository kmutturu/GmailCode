public class Repeat10KController {

    // Binds with the user provided value
    public Object[] userCollection {get;set {
        system.debug('value ......');
       wrappedCollection = toCollectionOfCollection(value);       
    }}

    // derived collection created, from user provided collection 
    // of upto 10000 items
    transient public List<List<Object>> wrappedCollection  {get; private set;}
    
    /*
        Converts a collection of Object to 
        collection of collection with parent collection holding upto 1000 items
    */
    static List<List<Object>> toCollectionOfCollection(List<Object> coll){
        system.debug('list of all values');
        List<List<Object>> mainList = new List<List<Object>>();
        List<Object> innerList = null;
        Integer idx = 0;
        for(Object obj:coll){
            if (Math.mod(idx++, 1000) == 0 ) {
                innerList = new List<Object>();
                mainList.add(innerList);
            }
            innerList.add(obj);            
        }        
        return mainList;
    }    
}