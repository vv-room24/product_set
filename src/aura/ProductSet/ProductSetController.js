/**
 * Created by vvermiichuk on 29.05.2019.
 */

({
    doInit : function (component, event, helper) {
        helper.getProductSetItems(component, event, helper)
    },

    handleSelectProductSet : function (component, event, helper) {
        helper.handleSelectProductSetEvent(component, event, helper);
        helper.getProductSetName(component, event, helper);
        helper.getProductSetTotalPrice(component, event, helper);
    },

    handleAddCategoryItem : function (component, event, helper) {
        helper.handleAddCategoryItemEvent(component, event, helper);
        helper.getProductSetTotalPrice(component, event, helper);
    },

    handleRemoveCategoryItem : function (component, event, helper) {
        helper.handleRemoveCategoryItemEvent(component, event, helper);
        helper.getProductSetTotalPrice(component, event, helper);
    },

    handleWuffleButton : function (component, event, helper) {
        helper.showToast(component, event, helper);

    },

    handleNewProductSet : function (component, event, helper) {
        helper.createNewProductSet(component, event, helper);
    }
});