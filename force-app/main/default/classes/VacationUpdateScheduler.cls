global class VacationUpdateScheduler implements Schedulable {
   global void execute(SchedulableContext sc) {
       VacationUpdateBatch b = new  VacationUpdateBatch(); 
      database.executebatch(b);
   }
}