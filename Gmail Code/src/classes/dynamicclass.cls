public class dynamicclass{

    
    public dynamicclass(ApexPages.StandardController controller) {
      
    }

public Component.Apex.Repeat getMyFieldSetSection()
{
     Component.Apex.Repeat rTag = new Component.Apex.Repeat( var = 'f');
     rTag.expressions.value='{!$ObjectType.Opportunity.FieldSets.Test}';
     Component.Apex.inputField oppTotal = new Component.Apex.inputField();
     oppTotal.expressions.value='{!Opportunity[f]}';
     rTag.childComponents.add(oppTotal);
     return rTag;
}
}