trigger ProductSetUpdate on Set_Item__c (after insert, after update, after delete) {
	
    if (Trigger.isAfter && Trigger.isInsert) {
        /*ProductSetUpdateHandler.updateTotalPrice();
        ProductSetUpdateHandler.updateHighestItemPrice();*/
        ProductSetter.updateTotalPrice(Trigger.new);
	}
    
    if (Trigger.isAfter && Trigger.isUpdate) {
        ProductSetUpdateHandler.updateTotalPrice();
        ProductSetUpdateHandler.updateHighestItemPrice();
    }
    
    if (Trigger.isAfter && Trigger.isDelete) {
        ProductSetUpdateHandler.updateTotalPrice();
        ProductSetUpdateHandler.updateHighestItemPrice();
    }
}