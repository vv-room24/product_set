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
                console.log(categories);
                console.log(productNames);
            }
            else {
                console.log("Failed with state: " + state);
            }
        }));
        $A.enqueueAction(action);
    },

    getCategoryItems : function (component, event, helper) {
        var selectedItems = [];
        var products = component.get("v.products");
        var selectedCategory = component.find("accordion").get("v.activeSectionName");
        console.log(selectedCategory + " selected");
        for(var i = 0; i < products.length; i++){
            if (products[i].Category__c == selectedCategory)
                selectedItems.push(products[i].Name);
        };
        component.set("v.categoryItems", selectedItems);
    }
});