trigger ProductSetUpdate on Set_Item__c (after insert, after update, after delete) {
	
    if (Trigger.isAfter && Trigger.isInsert) {
        ProductSetUpdateHandler.updateTotalPrice(Trigger.new);
        ProductSetUpdateHandler.updateHighestItemPrice(Trigger.new);
	}
    
    if (Trigger.isAfter && Trigger.isUpdate) {
        ProductSetUpdateHandler.updateTotalPrice(Trigger.new);
        ProductSetUpdateHandler.updateHighestItemPrice(Trigger.new);
    }
    
    if (Trigger.isAfter && Trigger.isDelete) {
        ProductSetUpdateHandler.updateTotalPrice(Trigger.new);
        ProductSetUpdateHandler.updateHighestItemPrice(Trigger.new);
    }
}