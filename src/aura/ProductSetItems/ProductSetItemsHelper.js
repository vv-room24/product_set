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
        var selected = component.find("selectProductSet").get("v.value");
        if (selected === "New Set"){
            helper.createRecord(component, event, helper);
            // console.log("matched");
            // component.set("v.isOpen", true);
            // console.log(component.get("v.isOpen"));
        }else {
            var selectedPSEvent = component.getEvent("changeProductSet");
            selectedPSEvent.setParams({
                "productSetId": selected
            });
            selectedPSEvent.fire();
        }
    },

    closeModel: function(component, event, helper) {
        component.set("v.isOpen", false);
    },

    handleNewSetSave : function (component, event, helper) {

        var action = component.get("c.createNewSet");
        action.setParams({
            name: component.get("v.newSetName")
        });

        action.setCallback(this, $A.getCallback(function (response) {
            var state = response.getState();
            if(component.isValid() && state === "SUCCESS"){
                console.log(component.get("v.newSetName") + " is created");
            }
            else {
                console.log("Failed with state: " + state);
            }
        }));
        $A.enqueueAction(action);
    },

    createRecord : function (component, event, helper) {
        var createNewProductSet = $A.get("e.force:createRecord");
        createNewProductSet.setParams({
            "entityApiName": "Product_Set__c",
            "defaultFieldValues": {
                'Name' : component.get("v.newSetName"),
                'Total_Price__c' : 0,
                'Highest_Item_Price__c' : 0
            }
        });
        createNewProductSet.fire();
    },

    showToast : function(component, event, helper) {
        var toastEvent = $A.get("e.force:showToast");
        toastEvent.setParams({
            "title": component.get("v.newSetName"),
            "message": "Set has been created successfully",
            "type": "success"
        });
        toastEvent.fire();
    }
});