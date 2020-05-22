global class LeaveTracker_UpdateActualLeaves
{
@InvocableMethod
public static void calculateWorkingDaysBetweenTwoDates(List<Vacation__c> vcrecord)
{
    system.debug('Record : '+ vcrecord);
    List<Vacation__c> holidays = [SELECT Holiday_Date__c FROM Vacation__c WHERE RecordType.DeveloperName = 'Company_Holiday'];
    Decimal c=0;
    Integer allDaysBetween = Integer.valueof(vcrecord[0].Number_Of_Days__c);
    system.debug('----allDaysBetween = '+allDaysBetween);
    //if((vcrecord[0].Number_Of_Days__c).scale()==1) c=0.5;
    c = vcrecord[0].Number_Of_Days__c- Integer.valueof(vcrecord[0].Number_Of_Days__c);
    Integer allWorkingDays = 0;
    for(Integer k = 0; k < allDaysBetween ;k++ )
    {
        if(checkifWorkingDay(vcrecord[0].From__c.addDays(k), holidays))
        {
            allWorkingDays++;
        }
    }
     //return allWorkingDays;
    Vacation__c vc = [SELECT Id,No_of_Actual_Leaves__c FROM Vacation__c WHERE Id =: vcrecord[0].Id];
    vc.No_of_Actual_Leaves__c = allWorkingDays+c;
    update vc;
}

public static boolean checkifWorkingDay(Date currentDate, List<Vacation__c> holidays)
{
    Date weekStart = currentDate.toStartofWeek();
    for(Vacation__c hDay : holidays)
    {
       if(currentDate.daysBetween(hDay.Holiday_Date__c) == 0)
        {
            return false;
        }
    }
    if(weekStart.daysBetween(currentDate) == 0 || weekStart.daysBetween(currentDate) == 6)
    {
        return false;
    }
    else
    {
        return true;
   }
  }
  }