trigger ProductSetUpdate on Set_Item__c (after insert, after update, before delete, after delete) {
    
    if (Trigger.isAfter && Trigger.isInsert) {
        ProductSetPriceHandler psph = new ProductSetPriceHandler(Trigger.new);
        psph.updateTotalPrice();
        psph.updateHighestItemPrice();
    }
    
    if (Trigger.isAfter && Trigger.isUpdate) {
        ProductSetPriceHandler psph = new ProductSetPriceHandler(Trigger.new);
        psph.updateTotalPrice();
        psph.updateHighestItemPrice();
    }
    
    if (Trigger.isBefore && Trigger.isDelete) {
        ProductSetPriceHandler psph = new ProductSetPriceHandler(Trigger.old);
        psph.updateDeletedTotalPrice();
    }

    if (Trigger.isAfter && Trigger.isDelete) {
        ProductSetPriceHandler psph = new ProductSetPriceHandler(Trigger.old);
        psph.updateDeletedHighestItemPrice();
}
}