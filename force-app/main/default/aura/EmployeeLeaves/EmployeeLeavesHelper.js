({
	getData : function(component) {
        var action = component.get('c.getEmployeeLeavesData');
        var recId = component.get('v.recordId');
		action.setParams({
            		referenceRecId:recId
       				 });        
        action.setCallback(this, $A.getCallback(function (response){
console.log('RetVal'+response.getReturnValue());
if(response.getReturnValue() != null){
            	var empl = response.getReturnValue().employee;
            	var availedCL = response.getReturnValue().availedCasualLeave;
            	var availableCL = response.getReturnValue().availableCasualLeave;
            	var availedSL = response.getReturnValue().availedSickLeave;
                var availableSL = response.getReturnValue().availableSickLeave;
		console.log('FFFFFFF'+empl+'-'+availedCL+'-'+availableCL+'-'+availedSL+'-'+
                            availableSL);
            	
            	component.set("v.employee", empl);
            	component.set("v.availedCasualLeave", availedCL);
            	component.set("v.availableCasualLeave", availableCL);
            	component.set("v.availedSickLeave", availedSL);
                component.set("v.availableSickLeave", availableSL);
		 }
        }));
        $A.enqueueAction(action);
	},

})