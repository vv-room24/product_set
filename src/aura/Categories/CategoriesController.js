/**
 * Created by vvermiichuk on 05.06.2019.
 */

({
    doInit : function (component, event, helper) {
        helper.getProducts(component, event, helper);
        helper.getSetItems(component, event, helper);
    },

    handleSelectedProductSet : function (component, event, helper) {
        helper.handleMatchedProducts(component, event, helper);
    },

    handleAccordionSectionToggle : function (component, event, helper) {
        helper.getCategoryItems(component, event, helper);
    },

    removeItem : function (component, event, helper) {
        if (component.get("v.selectedProductSet") == null) {
            helper.showNullSetToast(component, event, helper);
        }else {
            helper.fireAddCategoryItemEvent(component, event, helper);
            helper.updateCategoryItems(component, event, helper);
        }
    },

    handleRemovedItem : function (component, event, helper) {
        helper.changeProductItems(component, event, helper);
    }

});