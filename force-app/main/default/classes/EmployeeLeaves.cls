public with sharing class EmployeeLeaves {
    
    @AuraEnabled
    public static ResponseWrapper getEmployeeLeavesData(String referenceRecId) {
        ResponseWrapper RespWrapper = new ResponseWrapper();
        Vacation__c vacrecord = new Vacation__c();
        vacrecord = [SELECT Id, Employee__c, Employee_Name__c, Employee__r.Availed_Casual_Leaves__c, Employee__r.Available_Casual_Leaves__c, 
            Employee__r.Availed_Sick_Leaves__c, Employee__r.Available_Sick_Leaves__c FROM Vacation__c WHERE Id = :referenceRecId];
        if(vacrecord!=null) {
            RespWrapper.employee=vacrecord.Employee_Name__c;
            RespWrapper.availedCasualLeave=String.valueof(vacrecord.Employee__r.Availed_Casual_Leaves__c);
            RespWrapper.availableCasualLeave=String.valueof(vacrecord.Employee__r.Available_Casual_Leaves__c);
            RespWrapper.availedSickLeave=String.valueof(vacrecord.Employee__r.Availed_Sick_Leaves__c);
            RespWrapper.availableSickLeave=String.valueof(vacrecord.Employee__r.Available_Sick_Leaves__c);
            return RespWrapper;
        }
        else {
            return null;
        }   
    }
    
    public class ResponseWrapper
    {
        @AuraEnabled
        public String employee;
       @AuraEnabled
        public String availedCasualLeave;
        @AuraEnabled
        public String availableCasualLeave;
        @AuraEnabled
        public String availedSickLeave;
        @AuraEnabled
        public String availableSickLeave;    
    }
}