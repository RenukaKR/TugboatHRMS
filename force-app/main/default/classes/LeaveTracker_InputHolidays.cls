public class LeaveTracker_InputHolidays {
    public List<Vacation__c> holsLst {get; set;}

    public LeaveTracker_InputHolidays(ApexPages.StandardController myController) {
        
        holsLst = new List<Vacation__c>();
        Vacation__c holsrec = new Vacation__c();
        holsLst.add(holsrec); }
 
    public void addrow() {
        Vacation__c holsrec = new Vacation__c();
        holsLst.add(holsrec); }
             
    public void removerow(){
        Integer i = holsLst.size();
        holsLst.remove(i-1); }
             
    public PageReference save() {
        If(holsLst!=null && holsLst.size()>0)
        insert holsLst;
        PageReference home = new PageReference('https://ap5.lightning.force.com/lightning/o/Vacation__c/list?filterName=00B7F0000040FaoUAE');
        home.setRedirect(true);
        return home; }}