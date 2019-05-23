trigger ProductSetUpdate on Set_Item__c (after insert, after update, after delete) {
	
    if (Trigger.isAfter && Trigger.isInsert) {
        /*ProductSetUpdateHandler.updateTotalPrice();
        ProductSetUpdateHandler.updateHighestItemPrice();
        ProductSetter ps = new ProductSetter(Trigger.new);
        ps.updateTotalPrice();
        ps.updateHighestItemPrice();*/
        ProductSetter psUpdater = new ProductSetter(Trigger.new);
        psUpdater.updateTotalPrice();
        psUpdater.updateHighestItemPrice();
    }
    
    if (Trigger.isAfter && Trigger.isUpdate) {
        ProductSetter psUpdater = new ProductSetter(Trigger.new);
        psUpdater.updateTotalPrice();
        psUpdater.updateHighestItemPrice();
    }
    
    if (Trigger.isAfter && Trigger.isDelete) {
        ProductSetter psUpdater = new ProductSetter(Trigger.new);
        psUpdater.updateTotalPrice();
        psUpdater.updateHighestItemPrice();
    }
}