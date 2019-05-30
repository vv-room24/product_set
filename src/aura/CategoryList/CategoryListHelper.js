/**
 * Created by vvermiichuk on 30.05.2019.
 */

({
    getCategories : function (component, event, helper) {
        var action = component.get('c.getCategories');

        action.setCallback(this, $A.getCallback(function (response) {
            var state = response.getState();
            if(component.isValid() && state === "SUCCESS"){
                component.set("v.categoryList", response.getReturnValue());
            }
            else {
                console.log("Failed with state: " + state);
            }
        }));
        $A.enqueueAction(action);
    }
});