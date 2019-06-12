/**
 * Created by vvermiichuk on 28.05.2019.
 */

({
    doInit : function (component, event, helper) {
        helper.getProductSets(component);
    },

    handleSelectProductSet : function (component, event, helper) {
        helper.fireSelectProductSetEvent(component, event, helper);
    },

    closeModel : function (component, event, helper) {
        helper.closeModel(component, event, helper);
    },

    saveNewSet : function (component, event, helper) {
        helper.handleNewSetSave(component, event, helper);
        helper.createRecord(component, event, helper);
        helper.closeModel(component, event, helper);
        helper.showToast(component, event, helper);
    }
});