trigger checkempno on Employee__c (before insert, before update) {
    EmployeeTriggerHandler handler = new EmployeeTriggerHandler();
    //After Insert
    if(Trigger.isInsert && Trigger.isBefore){
        handler.onbeforeinsert(Trigger.new);   
        }
    if(Trigger.isUpdate && Trigger.isBefore){
        handler.onbeforeupdate(Trigger.new);   
        }
}