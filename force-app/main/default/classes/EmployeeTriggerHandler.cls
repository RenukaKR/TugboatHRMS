public with sharing class EmployeeTriggerHandler {

public void OnBeforeInsert(List<Employee__c> NewEmpRec) {
    Boolean check;
    //List<Employee__c> toinsertemplist = new List<Employee__c>();
    List<Employee__c> emplist = [SELECT Employee_Number__c FROM Employee__c];
    for(Employee__c emprecord : NewEmpRec) {
        check = true;
        String empno = emprecord.Employee_Number__c;
        for(Employee__c emprec : emplist) {
            if(empno==emprec.Employee_Number__c) {
                //ApexPages.Message errorMessage = new ApexPages.Message(ApexPages.Severity.ERROR, 'This Employee Number already exists!');
                //ApexPages.addMessage(errorMessage);
                Trigger.new[0].addError('This Employee Number already exists!');
                check=false;
                }
             }
             //if(check==true) toinsertemplist.add(emprecord);
         } 
        //if(toinsertemplist!=null && toinsertemplist.size()>0){
            //update toinsertemplist;               
            //}
     }
     
public void onBeforeupdate(List<Employee__c> NewEmpRec) {
    /*Boolean check;
    //List<Employee__c> toinsertemplist = new List<Employee__c>();
    List<Employee__c> emplist = [SELECT Employee_Number__c FROM Employee__c];
    for(Employee__c emprecord : NewEmpRec) {
        system.debug('Record: '+ emprecord.Employee_Number__c);
        check = true;
        String empno = emprecord.Employee_Number__c;
        
        for(Employee__c emprec : emplist) {
            if((empno==emprec.Employee_Number__c) && (emprecord.Id !=emprec.Id)) {
            //ApexPages.Message errorMessage = new ApexPages.Message(ApexPages.Severity.ERROR, 'This Employee Number already exists!');
            //ApexPages.addMessage(errorMessage);
            //Trigger.new[0].addError('This Employee Number already exists!');
            emprec.addError('This Employee Number already exists!');
            check=false;
            }
        }
             //if(check==true) toinsertemplist.add(emprecord);
    } */
    Map<String,Employee__c> emplistmap = new Map<String,Employee__c>();
    for(Employee__c emprecord : NewEmpRec) {
        Employee__c oldemprecord = (Employee__c) System.Trigger.oldMap.get(emprecord.Id); 
        if((emprecord.Employee_Number__c != null) && (emprecord.Employee_Number__c != oldemprecord.Employee_Number__c)) {   
            if(emplistmap.containskey(emprecord.Employee_Number__c)) {
                emprecord.Employee_Number__c.addError('This Employee Number already exists!');
            }
            else {
                emplistmap.put(emprecord.Employee_Number__c,emprecord);
            }
        }                 
    }
    for(Employee__c emplistdb : [SELECT Employee_Number__c FROM Employee__c WHERE Employee_Number__c IN : emplistmap.keyset()]) {
        Employee__c emprec = emplistmap.get(emplistdb.Employee_Number__c);
        emprec.Employee_Number__c.addError('This Employee Number already exists!');
    }    
}
}