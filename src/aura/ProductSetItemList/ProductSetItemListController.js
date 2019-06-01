/**
 * Created by vvermiichuk on 29.05.2019.
 */

({
    doInit : function (component, event, helper) {
        helper.getProductSetItems(component);
    },

    getSetDetalis : function (component, event, helper) {
        helper.getDetails(component);
        helper.openModel(component, event, helper);
    },

    closeModel : function (component, event, helper) {
        helper.closeModel(component, event, helper);
    },

});