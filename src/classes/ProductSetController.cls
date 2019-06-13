/**
 * Created by vvermiichuk on 30.05.2019.
 */

public with sharing class ProductSetController {

    @AuraEnabled
    public static String getProductSetName(Id productSetId){
        String productSetName;
        List <String> names = new List<String>();
        for (Product_Set__c name : [SELECT Name FROM Product_Set__c WHERE Id = : productSetId]){
            names.add(name.Name);
        }
        productSetName = names.get(0);
        return productSetName;
    }

    @AuraEnabled
    public static Decimal getProductSetTotalPrice(Id productSetId){
        Decimal totalPrice;
        for (Product_Set__c namePrice : [SELECT Total_Price__c FROM Product_Set__c WHERE Id = : productSetId]){
            totalPrice = namePrice.Total_Price__c;
        }
        return totalPrice;
    }

    @AuraEnabled
    public static List <String> getSetItems(Id productSetId) {
        List<String> productItems = new List<String>();
        for (Set_Item__c productItem : [SELECT Product_Item__r.Name FROM Set_Item__c WHERE Product_Set__r.Id = :productSetId]) {
            productItems.add(productItem.Product_Item__r.Name);
        }
        return productItems;
    }

    @AuraEnabled
    public static void addSetItem(String productItemName, Id selectedProductSet){
        Id productItemId;
        for (Product_Item__c productItem : [SELECT Id FROM Product_Item__c WHERE Name =: productItemName]){
            productItemId = productItem.Id;
        }
        String productSetName;
        for (Product_Set__c productSet : [SELECT Name FROM Product_Set__c WHERE Id =: selectedProductSet]){
            productSetName = productSet.Name;
        }
        Set_Item__c newSetItem = new Set_Item__c();
        newSetItem.Product_Item__c = productItemId;
        newSetItem.Product_Set__c = selectedProductSet;
        newSetItem.Name = productSetName + '_' + productItemName;
        insert newSetItem;
    }

}