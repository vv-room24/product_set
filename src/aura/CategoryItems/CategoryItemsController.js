/**
 * Created by vvermiichuk on 30.05.2019.
 */

({
    doInit : function (component, event, helper) {
        helper.getCategoryNames(component, event, helper)
    },

    removeItem : function (component, event, helper) {
        helper.fireAddCategoryItemEvent(component, event, helper);
        helper.updateCategoryItems(component, event, helper);
    }
});