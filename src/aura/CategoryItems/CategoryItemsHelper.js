/**
 * Created by vvermiichuk on 30.05.2019.
 */

({
    getCategoryNames : function (component, event, helper) {
        var action = component.get('c.getProductItemsNames');
        action.setParams({
                category: component.get("v.toggledCategoryItems")
            })

        action.setCallback(this, $A.getCallback(function (response) {
            var state = response.getState();
            if(component.isValid() && state === "SUCCESS"){
                component.set("v.items", response.getReturnValue());
            }
            else {
                console.log("Failed with state: " + state);
            }
            console.log(response.getReturnValue());
        }));
        $A.enqueueAction(action);
    }
});