public class Repeat10kTestController {
// Collection of intergers to hold 10000 items
public List<Integer> integers {get;set;}

{
    // Populate the collection in initalizer block
    integers = new List<Integer>();
    for (Integer idx = 1; idx <= 15001; idx++) integers.add(idx);
}

}