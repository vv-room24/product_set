/**
 * Created by vvermiichuk on 29.05.2019.
 */

({
    doInit : function (component, event, helper) {
        helper.getProductSetItems(component);
        helper.setTableData(component, event, helper);
    },

    getSetDetails : function (component, event, helper) {
        helper.getDetails(component);
        helper.setTableData(component, event, helper);
        helper.openModel(component, event, helper);
    },

    closeModel : function (component, event, helper) {
        helper.closeModel(component, event, helper);
    },

    removeItem : function (component, event, helper) {
        helper.fireRemoveCategoryItemEvent(component, event, helper);
        helper.updateCategoryItems(component, event, helper);
    },

    handleCreateNewProductSet : function (component, event, helper) {
        helper.createNewProductSet(component, event, helper);
    }

});