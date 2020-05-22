/*
Type: Custom Batch class
Name:VacationUpdateBatch
*/
global class VacationUpdateBatch implements Database.Batchable<sObject> {
 
 
 
 global VacationUpdateBatch () {
  //UpdateEligibleCasualSickLeaves();
 }
 
 global Database.QueryLocator start(Database.BatchableContext BC) {
  //return Database.getQueryLocator('SELECT Current_Year__c,From__c FROM Vacation__c where From__c=Next_Year');
  return Database.getQueryLocator('SELECT Id, Eligible_Casual_Leaves__c, Eligibled_Sick_Leaves__c FROM Employee__c');
   }

    global void execute(Database.BatchableContext BC, List<sObject> scope) 
    {
    if((system.Today().month())==12)
    {
    UpdateEligibleCasualSickLeaves(scope);
    List<Vacation__c> vacalist = new List<Vacation__c>();
    vacalist = [SELECT Current_Year__c,From__c FROM Vacation__c where From__c=Next_Year];
     if (vacalist!=null && vacalist.size()>0)
     {
     List<Vacation__c> updateList=new List<Vacation__c>();
     Vacation__c acc=new Vacation__c();
     for (sObject vccobj: vacalist)
      {
          //if(acc.From__c.month()==12){
           acc = (Vacation__c)vccobj;
           acc.Current_Year__c=True;   
          //}
            
            system.debug(acc.From__c.month());
           
   
   //change it to vacation and update 
   updateList.add(acc);
    
  }
  //update updateList;
  Database.SaveResult[] results = Database.update(updateList, false);
  system.debug(results);
  EmailBatchRecords();
 }
 }
 }
 
 global void finish(Database.BatchableContext BC) {
  //EmailBatchRecords();
  
 }
 public void EmailBatchRecords(){
        String body = 'Please check the details of batch update';

        Messaging.SingleEmailmessage mail = new Messaging.SingleEmailmessage();
        String[] toAddresses = new String[] {system.Label.BatchRecordsEmailID} ;
        mail.setToAddresses(toAddresses) ;
        mail.setSubject('Job Name :VacationUpdateBatch Batch Summary');
        //Body of email
        mail.setHtmlBody('Hi, ' + '<br /><br />' + body + '<br /> <br />Thanks & Regards, <br /> Admin');
        //Sending the email
       if (!Test.isRunningTest()) {
            Messaging.sendEmail(new Messaging.SingleEmailMessage[] { mail });
            system.debug('mail Sent');
        }
    }
    
 public void UpdateEligibleCasualSickLeaves(List<Employee__c> emplist) {
     //List<Employee__c> emplist = new List<Employee__c>();
     List<Employee__c> updatedemplist = new List<Employee__c>();
     //emplist = [SELECT Id, Eligible_Casual_Leaves__c, Eligibled_Sick_Leaves__c FROM Employee__c];
     for(Employee__c emp : emplist)
     {
         emp.Eligible_Casual_Leaves__c = Decimal.valueof(system.label.Eligible_Casual_Leave);
         emp.Eligibled_Sick_Leaves__c = Decimal.valueof(system.label.Eligible_Sick_Leave);
         updatedemplist.add(emp);
     }
     update updatedemplist;
  }                
 
}