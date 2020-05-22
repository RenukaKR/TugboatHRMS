global class LeaveTracker_UpdateHRComments
{
@InvocableMethod
public static void updateComments(List<Vacation__c> vcrec)
{
List<Vacation__c> vcrecords = new List<Vacation__c>();
Vacation__c vcreco=vcrec[0];
vcrecords = [SELECT Id, Revoked__c, ( SELECT Id,Comments,CreatedDate FROM ProcessSteps ORDER BY CreatedDate DESC limit 1) FROM Vacation__c WHERE Id=:vcreco.id];

if(vcrecords.size()>0)
{
Vacation__c vc = vcrecords[0];
if(vc.Revoked__c==false)
{
ProcessInstanceHistory ps=vc.ProcessSteps[0];
if(ps!=null)
{
vc.HR_Comments__c=ps.Comments;
update vc;
}
}
}
}
}