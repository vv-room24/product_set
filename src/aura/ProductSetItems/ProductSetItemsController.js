/**
 * Created by vvermiichuk on 28.05.2019.
 */

({
    doInit : function (component, event, helper) {
        helper.getProductSets(component);
    },

    handleSelectProductSet : function (component, event, helper) {
        helper.fireSelectProductSetEvent(component, event, helper)
    }
});