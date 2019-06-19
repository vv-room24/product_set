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
        if (selected === component.find("createNewSetButton").get("v.label")){
            // helper.createRecord(component, event, helper);
            var selectedPSEvent = component.getEvent("changeProductSet");
            selectedPSEvent.setParams({
                "productSetId": null
            });
            selectedPSEvent.fire();
            var createProductSetEvent = component.getEvent("createProductSet");
            createProductSetEvent.setParams({
                "createFlag": true,
                "mainFlag": false
            });
            createProductSetEvent.fire();
        }else {
            var selectedPSEvent = component.getEvent("changeProductSet");
            selectedPSEvent.setParams({
                "productSetId": selected,
                "createFlag": false,
                "mainFlag": true
            });
            selectedPSEvent.fire();
        }
    }

    // createRecord : function (component, event, helper) {
    //     var createNewProductSet = $A.get("e.force:createRecord");
    //     createNewProductSet.setParams({
    //         "entityApiName": "Product_Set__c",
    //         "defaultFieldValues": {
    //             'Name' : component.get("v.newSetName"),
    //             'Total_Price__c' : 0,
    //             'Highest_Item_Price__c' : 0
    //         }
    //     });
    //     createNewProductSet.fire();
    // }

});