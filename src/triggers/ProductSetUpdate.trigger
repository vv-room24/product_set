trigger ProductSetUpdate on Set_Item__c (after insert, after update, before delete, after delete) {
    
    if (Trigger.isAfter && Trigger.isInsert) {
        ProductSetPriceHandler priceHandler = new ProductSetPriceHandler(Trigger.new);
        priceHandler.updateTotalPrice(Trigger.isDelete);
        priceHandler.updateHighestItemPrice();
    }
    
    if (Trigger.isAfter && Trigger.isUpdate) {
        ProductSetPriceHandler priceHandler = new ProductSetPriceHandler(Trigger.new);
        priceHandler.updateTotalPrice(Trigger.isDelete);
        priceHandler.updateHighestItemPrice();
    }
    
    if (Trigger.isBefore && Trigger.isDelete) {
        ProductSetPriceHandler priceHandler = new ProductSetPriceHandler(Trigger.old);
        priceHandler.updateTotalPrice(Trigger.isDelete);
    }

    if (Trigger.isAfter && Trigger.isDelete) {
        ProductSetPriceHandler priceHandler = new ProductSetPriceHandler(Trigger.old);
        priceHandler.updateDeletedHighestItemPrice();
}
}