trigger increaseCount on Employee__c (after insert) 
{
List<Employee__c> EmployeeToUpdate = new List<Employee__c>{};
for(Employee__c emp : Trigger.new)
  {
  Company__c company =[ select Number_of_Employees__c from Company__c where Id= :emp.Company__c ];
    if (company.Number_of_Employees__c==Null)
   {
   company.Number_of_Employees__c=1;
   }
   else
   {company.Number_of_Employees__c =company.Number_of_Employees__c+1;}
   update company;
  }
}