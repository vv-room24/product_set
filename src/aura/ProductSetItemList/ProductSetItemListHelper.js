/**
 * Created by vvermiichuk on 29.05.2019.
 */

({
    getProductSetItems : function (component) {
        var action = component.get("c.getProductSetItems");
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
    },

    getDetails : function (component) {
        var action = component.get("c.getDetails")
        action.setParams({
            id: component.get("v.productSetId")
        });

        action.setCallback(this, $A.getCallback(function (response) {
            var state = response.getState();
            if (component.isValid() && state === "SUCCESS") {
                component.set("v.productSetDetailed", response.getReturnValue());
            } else {
                console.log("Failed with state: " + state);
            }
        }));
        $A.enqueueAction(action);
    },

    openModel: function(component, event, helper) {
        // for Display Model,set the "isOpen" attribute to "true"
        component.set("v.isOpen", true);
    },

    closeModel: function(component, event, helper) {
        // for Hide/Close Model,set the "isOpen" attribute to "Fasle"
        component.set("v.isOpen", false);
    },
    
    updateCategoryItems : function (component, event, helper) {
        var items = component.get("v.productSetItems");
        var selected = event.getSource().get("v.value");
        console.log(items);
        console.log(selected);
        var index = items.indexOf(selected);
        if (index !== -1) items.splice(index, 1);
        component.set("v.productSetItems", items)
    }
});