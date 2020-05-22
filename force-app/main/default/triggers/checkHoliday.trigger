trigger checkHoliday on Vacation__c (before insert, before update) {
     VacationTriggerHandler handler = new VacationTriggerHandler();
     if(Trigger.isInsert && Trigger.isBefore){
        handler.onbeforeinsert(Trigger.new);   
     }
    if(Trigger.isUpdate && Trigger.isBefore){
        handler.onbeforeupdate(Trigger.new);   
     }

}