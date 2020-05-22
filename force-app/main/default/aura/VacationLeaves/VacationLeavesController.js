({
    init : function(component, event, helper) {
        component.set('v.columns', [
            {label:'From Date',fieldName:'From__c',type:'date'},
            {label:'To Date',fieldName:'To__c',type: 'date'},
	    {label:'Reason',fieldName:'Reason__c',type: 'text'}
        ]);
        
        helper.populateData(component);
        /*var action = component.get("c.getUIThemeDescription");
        action.setCallback(this, function(a) {
        	component.set("v.Name", a.getReturnValue());
		});
		$A.enqueueAction(action);*/
   }	
})