public class VacationLeaves {

    @AuraEnabled
    public static List<Vacation__c> getDetails(String referenceRecId)
    {
        Boolean flag = true;
        Vacation__c vacrecord = new Vacation__c();
        List<Vacation__c> vacrecordLst = new List<Vacation__c>();
        vacrecord = [SELECT Id, Employee__c, Employee_Name__c FROM Vacation__c WHERE Id = :referenceRecId];
        if(vacrecord!=null) {
            String empname = vacrecord.Employee_Name__c;
            vacrecordLst = [SELECT Id, Name, From__c, To__c, Reason__c, Employee_Name__c FROM Vacation__c WHERE Employee_Name__c = :empname];
            if(vacrecordlst==null) {
               flag=false;
            }    
            
        }
        else {
            flag=false;
        }
        if(flag==true) {
            return vacrecordLst;
        }
        else {
            return null;
        }        
    } 
    
    @AuraEnabled
    public static String getUIThemeDescription() {
        String theme = UserInfo.getUiThemeDisplayed();
        return theme;
    }
}