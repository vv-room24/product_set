/**
 * Created by vvermiichuk on 29.05.2019.
 */

({
    handleSelectProductSetEvent : function (component, event, helper) {
        var selectedProductSet = event.getParam("productSetId");
        component.set("v.selectedProductSet", selectedProductSet);
    }
});