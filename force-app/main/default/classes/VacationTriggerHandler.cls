public with sharing class VacationTriggerHandler {

public void OnBeforeInsert(List<Vacation__c> NewVacRec) {
    
    If(NewVacRec[0].RecordType.DeveloperName == 'Employee_Leave') {
        List<Vacation__c> holidays = [SELECT Holiday_Date__c FROM Vacation__c WHERE RecordType.DeveloperName = 'Company_Holiday'];
        if(holidays.size()>0) {
            for(Vacation__c hDay : holidays)
            {
                If(((NewVacRec[0].From__c).daysBetween(hDay.Holiday_Date__c) == 0) || ((NewVacRec[0].To__c).daysBetween(hDay.Holiday_Date__c) == 0))
                Trigger.new[0].addError('One of the dates you entered is a Company Holiday. Please select a new date');
            }
            Date weekStart1 = (NewVacRec[0].From__c).toStartofWeek();
            Date weekStart2 = (NewVacRec[0].To__c).toStartofWeek();
            if(weekStart1.daysBetween(NewVacRec[0].From__c) == 0 || weekStart1.daysBetween(NewVacRec[0].From__c) == 6 || weekStart2.daysBetween(NewVacRec[0].To__c) == 0 || weekStart2.daysBetween(NewVacRec[0].To__c) == 6)
            Trigger.new[0].addError('One of the dates you entered is a Saturday or Sunday. Please select a new date');
            List<Vacation__c> vacrecordlst = [SELECT Employee__c,From__c,From_Day__c,To__c, To_Day__c, Status__c FROM Vacation__c WHERE RecordType.DeveloperName = 'Employee_Leave'];
            for(Vacation__c vDay : vacrecordlst)
            {
              if((vDay.Status__c != 'Cancelled') && (NewVacRec[0].Employee__c == vDay.Employee__c) && (NewVacRec[0].From_Day__c == vDay.From_Day__c) && (NewVacRec[0].From_Day__c == 'Full Day') && (NewVacRec[0].To_Day__c == vDay.To_Day__c)  && (NewVacRec[0].To_Day__c == 'Full Day') && (((NewVacRec[0].From__c >= vDay.From__c) && (NewVacRec[0].From__c <= vDay.To__c)) || ((NewVacRec[0].To__c <= vDay.To__c)) && (NewVacRec[0].To__c >= vDay.From__c)))
              Trigger.new[0].addError('Leave already exists for this date');
              //else if((NewVacRec[0].Employee__c==vDay.Employee__c) && (NewVacRec[0].To__c == vDay.To__c) && (NewVacRec[0].To_Day__c == vDay.To_Day__c)  && (NewVacRec[0].To_Day__c == 'Full Day'))
              //Trigger.new[0].addError('Leave already exists for this To date'); 
            }
        } 
    }                   
}

public void OnBeforeUpdate(List<Vacation__c> NewVacRec) {
    
    If(NewVacRec[0].RecordType.DeveloperName == 'Employee_Leave') {
        List<Vacation__c> holidays = [SELECT Holiday_Date__c FROM Vacation__c WHERE RecordType.DeveloperName = 'Company_Holiday'];
        if(holidays.size()>0) {
            for(Vacation__c hDay : holidays)
            {
                If(((NewVacRec[0].From__c).daysBetween(hDay.Holiday_Date__c) == 0) || ((NewVacRec[0].To__c).daysBetween(hDay.Holiday_Date__c) == 0))
                Trigger.new[0].addError('One of the dates you entered is a Company Holiday. Please select a new date');
            }
            Date weekStart1 = (NewVacRec[0].From__c).toStartofWeek();
            Date weekStart2 = (NewVacRec[0].To__c).toStartofWeek();
            if(weekStart1.daysBetween(NewVacRec[0].From__c) == 0 || weekStart1.daysBetween(NewVacRec[0].From__c) == 6 || weekStart2.daysBetween(NewVacRec[0].To__c) == 0 || weekStart2.daysBetween(NewVacRec[0].To__c) == 6)
            Trigger.new[0].addError('One of the dates you entered is a Saturday or Sunday. Please select a new date');
            Vacation__c oldVacation = (Vacation__c) Trigger.oldMap.get(NewVacRec[0].ID);
            if((NewVacRec[0].Employee__c <> oldVacation.Employee__c) || (NewVacRec[0].From__c <> oldVacation.From__c) || (NewVacRec[0].From_Day__c <> oldVacation.From_Day__c) || (NewVacRec[0].To__c <> oldVacation.To__c) || (NewVacRec[0].To_Day__c <> oldVacation.To_Day__c)) {
                List<Vacation__c> vacrecordlst = [SELECT Employee__c,From__c,From_Day__c,To__c, To_Day__c,Status__c FROM Vacation__c WHERE RecordType.DeveloperName = 'Employee_Leave'];
                for(Vacation__c vDay : vacrecordlst)
                {
                  if((vDay.Status__c != 'Cancelled') && (NewVacRec[0].Employee__c == vDay.Employee__c) && (NewVacRec[0].From_Day__c == vDay.From_Day__c) && (NewVacRec[0].From_Day__c == 'Full Day') && (NewVacRec[0].To_Day__c == vDay.To_Day__c)  && (NewVacRec[0].To_Day__c == 'Full Day') && (((NewVacRec[0].From__c >= vDay.From__c) && (NewVacRec[0].From__c <= vDay.To__c)) || ((NewVacRec[0].To__c <= vDay.To__c)) && (NewVacRec[0].To__c >= vDay.From__c)))
                  Trigger.new[0].addError('Leave already exists for this date');
                  //else if((NewVacRec[0].Employee__c==vDay.Employee__c) && (NewVacRec[0].To__c == vDay.To__c) && (NewVacRec[0].To_Day__c == vDay.To_Day__c)  && (NewVacRec[0].To_Day__c == 'Full Day'))
                  //Trigger.new[0].addError('Leave already exists for this To date'); 
                }   
            }
        }
    }        
}
}