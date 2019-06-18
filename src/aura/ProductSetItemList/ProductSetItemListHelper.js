/**
 * Created by vvermiichuk on 29.05.2019.
 */

({
    getProductSetItems : function (component) {
        var action = component.get("c.getProductSetItems");
        var productSetId = component.get("v.productSetId");
        if (productSetId === "NULL"){
            var nullSetItems = [];
            component.set("v.productSetItems", nullSetItems),
            component.set("v.productSetName", ""),
            component.set("v.productSetTotalPrice", "")

        }else {
            action.setParams({
                productSetId: productSetId
            });

            action.setCallback(this, $A.getCallback(function (response) {
                var state = response.getState();
                if (component.isValid() && state === "SUCCESS") {
                    component.set("v.productSetItems", response.getReturnValue());
                } else {
                    console.log("Failed with state: " + state);
                }
            }));
            $A.enqueueAction(action);
        }
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
        // for Hide/Close Model,set the "isOpen" attribute to "False"
        component.set("v.isOpen", false);
    },
    
    updateCategoryItems : function (component, event, helper) {
        var items = component.get("v.productSetItems");
        var selected = event.getSource().get("v.value");
        var index = items.indexOf(selected);
        if (index !== -1) items.splice(index, 1);
        component.set("v.productSetItems", items)
    },

    fireRemoveCategoryItemEvent : function (component, event, helper) {
        var selectedCIREvent = component.getEvent("removeCategoryItem");
        var selected = event.getSource().get("v.value");
        selectedCIREvent.setParams({
            "itemName" : selected
        });
        selectedCIREvent.fire();

    },

    setTableData: function (component, event, helper) {
        component.set('v.dataColumns', [
            {label: 'Product', fieldName: 'Name', type: 'text'},
            {label: 'Price', fieldName: 'Price__c', type: 'number'},
            {label: 'Category', fieldName: 'Category__c', type: 'text'}
        ]);
        helper.getData(component, event, helper);

    },

    getData : function(component, event, helper) {
        var action = component.get("c.getAllDetails");
        var productSetId = component.get("v.productSetId");
        if (productSetId === "NULL"){
            var nullSetItems = [];
                component.set("v.setData", nullSetItems)

        }else {
            action.setParams({
                id: component.get("v.productSetId")
            });
            action.setCallback(this, $A.getCallback(function (response) {
                var state = response.getState();
                if (component.isValid() && state === "SUCCESS") {
                    var rows = [];
                    var setItems = response.getReturnValue();
                    for (var i = 0; i < setItems.length; i++) {
                        var row = {
                            Name: setItems[i].Product_Item__r.Name,
                            Price__c: setItems[i].Product_Item__r.Price__c,
                            Category__c: setItems[i].Product_Item__r.Category__c
                        };
                        rows.push(row);
                    }
                    ;
                    component.set("v.setData", rows);
                } else {
                    console.log("Failed with state: " + state);
                }
            }));
            $A.enqueueAction(action);
        }
    }

});