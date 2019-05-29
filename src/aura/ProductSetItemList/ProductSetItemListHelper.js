/**
 * Created by vvermiichuk on 29.05.2019.
 */

({
    getProductSetItems : function (component) {
        var action = component.get('c.getProductSetItems');
        action.setParams({
            productSetId: component.get("v.productSetId")
        });

        action.setCallback(this, $A.getCallback(function (response) {
            var state = response.getState();
            if(component.isValid() && state === "SUCCESS"){
                component.set("v.productSetItems", response.getReturnValue());
            }
            else {
                console.log("Failed with state: " + state);
            }
        }));
        $A.enqueueAction(action);
    }
});