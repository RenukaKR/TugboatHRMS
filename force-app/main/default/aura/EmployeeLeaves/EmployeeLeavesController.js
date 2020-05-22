({
	//this function is to fetch all the user updates from the database
	doInit : function(component, event, helper) {
        helper.getData(component);
    },
     // this function is automatically called by aura:waiting event
    showSpinner : function (component, event, helper) {
        //console.log('IAMINSHOWSPINNER');
        component.set("v.Spinner", true);    
    },
    
	// this function is automatically called by aura:doneWaiting event
    hideSpinner : function (component, event, helper) {
        //console.log('IAMINHIDESPINNER');
        component.set("v.Spinner", false);    
    }
})