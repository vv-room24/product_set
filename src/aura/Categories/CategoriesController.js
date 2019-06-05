/**
 * Created by vvermiichuk on 05.06.2019.
 */

({
    doInit : function (component, event, helper) {
        helper.getProducts(component, event, helper);
    },

    handleAccordionSectionToggle : function (component, event, helper) {
        helper.getCategoryItems(component, event, helper);
    }
});