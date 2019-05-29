/**
 * Created by vvermiichuk on 28.05.2019.
 */

({
    getProductSets : function (component) {
        var action = component.get('c.getProductSets');

        action.setCallback(this, $A.getCallback(function (response) {
            var state = response.getState();
            if(component.isValid() && state === "SUCCESS"){
                component.set("v.productSets", response.getReturnValue());
            }
            else {
                console.log("Failed with state: " + state);
            }
        }));
        $A.enqueueAction(action);
    },

    fireSelectProductSetEvent : function (component, event, helper) {
        var productSet = component.get("v.selectedProductSet");
        var selectedPSEvent = component.getEvent("changeProductSet");
        selectedPSEvent.setParams({
            "productSetId" : productSet
        });
        selectedPSEvent.fire();
    }
});