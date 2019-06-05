/**
 * Created by vvermiichuk on 30.05.2019.
 */

({
    doInit : function (component, event, helper) {
        helper.getCategories(component, event, helper);
        helper.getCategoriesItems(component, event, helper);
    },

    newItemHandler : function (component, event, helper) {
        helper.handleNewItem(component, event, helper);
    }

});