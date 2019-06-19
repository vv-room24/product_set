/**
 * Created by vvermiichuk on 29.05.2019.
 */

({
    getProductSetItems : function (component, event, helper) {
        var action = component.get("c.getSetItems");

        action.setParams({
            productSetId: component.get("v.selectedProductSet"),
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

    handleSelectProductSetEvent : function (component, event, helper) {
        var selectedProductSet = event.getParam("productSetId");
        component.set("v.selectedProductSet", selectedProductSet);
        component.find("categories").getSetItems();
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
    },

    getProductSetTotalPrice : function (component, event, helper) {
        var action = component.get("c.getProductSetTotalPrice");
        action.setParams({
            productSetId: component.get("v.selectedProductSet")
        });

        action.setCallback(this, $A.getCallback(function (response) {
            var state = response.getState();
            if(component.isValid() && state === "SUCCESS"){
                component.set("v.productSetTotalPrice", response.getReturnValue());
            }
            else {
                console.log("Failed with state: " + state);
            }
        }));
        $A.enqueueAction(action);
    },

    handleAddCategoryItemEvent : function (component, event, helper) {
        var selectedProductSetItems = component.get("v.productSetItems")
        var selectedCategoryItem = event.getParam("itemName");
        selectedProductSetItems.push(selectedCategoryItem);
        component.set("v.productSetItems", selectedProductSetItems);

        var action = component.get("c.addSetItem");
        action.setParams({
            productItemName: selectedCategoryItem,
            selectedProductSet: component.get("v.selectedProductSet"),

        });

        action.setCallback(this, $A.getCallback(function (response) {
            var state = response.getState();
            if(component.isValid() && state === "SUCCESS"){
                console.log("Successful inserting with state: " + state);
            }
            else {
                console.log("Failed with state: " + state);
            }
        }));
        $A.enqueueAction(action);
    },

    handleRemoveCategoryItemEvent : function (component, event, helper) {
        var selectedCategoryItem = event.getParam("itemName");
        component.set("v.selectedItem", selectedCategoryItem);
        component.find("categories").returnCategoryItem();

        var action = component.get("c.removeSetItem");
        action.setParams({
            productItemName: selectedCategoryItem,
            selectedProductSet: component.get("v.selectedProductSet"),

        });

        action.setCallback(this, $A.getCallback(function (response) {
            var state = response.getState();
            if(component.isValid() && state === "SUCCESS"){
                console.log("Successful removing with state: " + state);
            }
            else {
                console.log("Failed with state: " + state);
            }
        }));
        $A.enqueueAction(action);
    },

    showToast : function(component, event, helper) {
        var toastEvent = $A.get("e.force:showToast");
        toastEvent.setParams({
            "title": "Warning!",
            "message": "Don't touch this button",
            "type": "Warning"
        });
        toastEvent.fire();
    },

    createNewProductSet : function (component, event, helper) {
        var createFlag = event.getParam("createFlag");
        component.set("v.newSetFormFlag", createFlag);
    }

});