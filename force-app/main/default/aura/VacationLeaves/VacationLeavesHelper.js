({
	populateData : function(component) {
		var action = component.get('c.getDetails');
        component.set('v.loaded', true);
	var recId = component.get('v.recordId');
		action.setParams({
            		referenceRecId:recId
       				 });
        action.setCallback(this, function (response)
                           {
                               console.log('data '+JSON.stringify(response.getReturnValue()));
                               //component.set('v.idsList',response.getReturnValue());
                               component.set('v.data',response.getReturnValue());
                               component.set('v.loaded', false);
                           });
        $A.enqueueAction(action);
	}
})