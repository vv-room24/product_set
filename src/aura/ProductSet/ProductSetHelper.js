/**
 * Created by vvermiichuk on 29.05.2019.
 */

({
    handleSelectProductSetEvent : function (component, event, helper) {
        var selectedProductSet = event.getParam("productSetId");
        component.set("v.selectedProductSet", selectedProductSet);
    },

    getProductSetName : function (component, event, helper) {
        var action = component.get("c.getProductSetName");
        action.setParams({
            productSetId: component.get("v.selectedProductSet")
        });

        action.setCallback(this, $A.getCallback(function (response) {
            var state = response.getState();
            if(component.isValid() && state === "SUCCESS"){
                component.set("v.productSetName", response.getReturnValue());
            }
            else {
                console.log("Failed with state: " + state);
            }
        }));
        $A.enqueueAction(action);
    }
});