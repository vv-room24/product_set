/**
 * Created by vvermiichuk on 05.06.2019.
 */

({
    getProducts : function (component, event, helper) {
        var action = component.get("c.getProductItems");
        var categories = [];
        var productNames = [];
        action.setCallback(this, $A.getCallback(function (response) {
            var state = response.getState();
            if(component.isValid() && state === "SUCCESS"){
                component.set("v.products", response.getReturnValue());
                var products = response.getReturnValue();
                for(var i = 0; i < products.length; i++){
                    if (!categories.includes(products[i].Category__c))
                        categories.push(products[i].Category__c);
                };
                for(var j = 0; j <products.length; j++ ){
                    productNames.push((products[j].Name))
                };
                component.set("v.categories", categories);
                component.set("v.categoryItems", productNames);
            }
            else {
                console.log("Failed with state: " + state);
            }
            window.globalProducts = response.getReturnValue();
        }));
        $A.enqueueAction(action);
    },

    getSetItems : function(component, event, helper){
        var action = component.get("c.getSetItems");
        action.setCallback(this, $A.getCallback(function (response) {
            var state = response.getState();
            if(component.isValid() && state === "SUCCESS"){
                component.set("v.setItems", response.getReturnValue());
            }
            else {
                console.log("Failed with state: " + state);
            }
            window.globalSetItems = response.getReturnValue();
        }));
        $A.enqueueAction(action);
        console.log("SetItems retrieved");
    },

    handleMatchedProducts : function(component, event, helper){
        component.set("v.products", window.globalProducts);
        component.set("v.setItems", window.globalSetItems);
        var products = component.get("v.products");
        var setItems = component.get("v.setItems");
        var categoryItems = component.get("v.categoryItems");
        var selectedProductSet = component.get("v.selectedProductSet");
        console.log(selectedProductSet);
        for (var i = 0; i < setItems.length; i++){
            console.log(setItems[i].Product_Set__r.Name);
            if (setItems[i].Product_Set__c == selectedProductSet){
                // for (var j = 0; j < products.length; j++){
                //     if (products[j].Name == setItems[i].Product_Item__r.Name){
                //         console.log(products[j].Name + "matched");
                //         products.splice(j, 1);
                //     }
                // }
                for (var j = 0; j < categoryItems.length; j++){
                    if(categoryItems[j] == setItems[i].Product_Item__r.Name){
                        console.log(categoryItems[j] + "matched");
                        categoryItems.splice(j, 1);
                    }
                }
            }
        }
        console.log(categoryItems);
        component.set("v.categoryItems", categoryItems)
        // component.set("v.products", products);
        console.log("products corrected");
    },

    getCategoryItems : function (component, event, helper) {
        var selectedItems = [];
        var products = component.get("v.products");
        var selectedCategory = component.find("accordion").get("v.activeSectionName");
        var categoryItems = component.get("v.categoryItems");
        for(var i = 0; i < products.length; i++){
            if (products[i].Category__c == selectedCategory)
                selectedItems.push(products[i].Name);
        };
        console.log(categoryItems);
        console.log(selectedItems);
        component.set("v.categoryItems", selectedItems.sort());
    },

    updateCategoryItems : function (component, event, helper) {
        var items = component.get("v.categoryItems");
        var selected = event.getSource().get("v.value");
        var products = component.get("v.products");
        console.log(selected);
        for(var i = 0; i < products.length; i++){
            if(products[i].Name === selected){
                products.splice(i, 1);
            }
        };
        component.set("v.products", products);

        for(var j = 0; j < items.length; j++){
            if (items[j] === selected)
                items.splice(j, 1);
        };
        component.set("v.categoryItems", items.sort());
    },

    fireAddCategoryItemEvent : function (component, event, helper) {
        var selectedCIEvent = component.getEvent("addCategoryItem");
        var selected = event.getSource().get("v.value");
        selectedCIEvent.setParams({
            "itemName" : selected
        });
        selectedCIEvent.fire();
    },

    changeProductItems : function (component, event, helper) {
        var selected = component.get("v.selectedItem");
        var items = component.get("v.categoryItems");
        var selectedCategory = component.find("accordion").get("v.activeSectionName");
        var products = component.get("v.products");

        var productNames = [];
        for(var i = 0; i < products.length; i++){
            productNames.push(products[i].Name);
            }
        if (!productNames.includes(selected)) {

            var newProduct = new function () {
                this.Name = selected, this.Category__c = selectedCategory
            };
            products.push(newProduct);
            component.set("v.products", products);
            items.push(newProduct.Name);
            component.set("v.categoryItems", items.sort());
        }else{
            alert("Select right category");

        }
    }

});