@isTest
private class VacationUpdateBatchTest{

    @testSetup
    static void setup(){
        list<Vacation__c> vacations=new list<Vacation__c>();
        Employee__c emp=new Employee__c(Name='surendra',Eligible_Casual_Leaves__c=5,Eligibled_Sick_Leaves__c=5 );
        insert emp;
        for (Integer i=0;i<10;i++){
            vacations.add(new Vacation__c(Current_Year__c=False,From__c=system.today().addMonths(12),Employee__c=emp.id));
        }
        insert Vacations;
    }
    
    static testmethod void test(){
        Test.startTest();
        VacationUpdateBatch vca=new VacationUpdateBatch();
        Id BatchId = Database.executeBatch(vca);
        Test.stopTest();
        system.assertEquals(10,[select count() from Vacation__c where From__c=Next_Year]);
    }

}