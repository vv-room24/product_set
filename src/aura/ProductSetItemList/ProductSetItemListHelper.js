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
        console.log("Table helper");
        component.set('v.dataColumns', [
            {label: 'Product', fieldName: 'Name', type: 'text'},
            {label: 'Price', fieldName: 'Price__c', type: 'number'},
            {label: 'Category', fieldName: 'Category__c', type: 'text'}
        ]);
        console.log(component.get('v.dataColumns'));
        helper.getData(component, event, helper);

    },

    getData : function(component, event, helper) {
        console.log(component.get("v.productSetId"));
        var action = component.get("c.getAllDetails");
        action.setParams({
            id: component.get("v.productSetId")
        });
        action.setCallback(this, $A.getCallback(function (response) {
            var state = response.getState();
            if(component.isValid() && state === "SUCCESS"){
                var rows = [];
                var setItems = response.getReturnValue();
                for(var i = 0; i < setItems.length; i++){
                    var row = {Name : setItems[i].Product_Item__r.Name,
                        Price__c : setItems[i].Product_Item__r.Price__c,
                        Category__c : setItems[i].Product_Item__r.Category__c
                    };
                    rows.push(row);
                };
                component.set("v.setData", rows);
                for(var i = 0; i < rows.length; i++){
                    console.log(rows[i].Name, rows[i].Price__c, rows[i].Category__c);
                }
            }
            else {
                console.log("Failed with state: " + state);
            }
        }));
        $A.enqueueAction(action);
        console.log(component.get("v.setData"));
    }

});