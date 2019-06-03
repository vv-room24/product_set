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
    },

    updateCategoryItems : function (component, event, helper) {
        var items = component.get("v.items");
        var selected = event.getSource().get("v.value");
        var index = items.indexOf(selected);
        if (index !== -1) items.splice(index, 1);
        component.set("v.items", items)
    }


});