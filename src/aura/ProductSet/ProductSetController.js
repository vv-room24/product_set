/**
 * Created by vvermiichuk on 29.05.2019.
 */

({
    handleSelectProductSet : function (component, event, helper) {
        helper.handleSelectProductSetEvent(component, event, helper);
        helper.getProductSetName(component, event, helper);
        helper.getProductSetTotalPrice(component, event, helper);
    }
});