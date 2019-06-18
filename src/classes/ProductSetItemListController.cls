/**
 * Created by vvermiichuk on 29.05.2019.
 */

public with sharing class ProductSetItemListController {

    @AuraEnabled
    public static List <String> getProductSetItems(Id productSetId){
        List <String> productItemsNames = new List<String>();
        for (Set_Item__c productItem : [SELECT Product_Item__r.Name, Product_Item__r.Category__c
                                        FROM Set_Item__c
                                        WHERE Product_Set__r.Id = : productSetId
                                        ORDER BY Product_Item__r.Name]){
            productItemsNames.add(productItem.Product_Item__r.Name);

        }
        return productItemsNames;
    }

    @AuraEnabled
    public static Product_Set__c getDetails(Id id){
        List <Product_Set__c> detail = [SELECT Name, Total_Price__c, Highest_Item_Price__c, Discount__c
                                        FROM Product_Set__c
                                        WHERE Id = :id];
        return detail[0];
    }

    @AuraEnabled
    public static List<Set_Item__c> getAllDetails(Id id){
        List<Set_Item__c> allDetails = [SELECT Name, Product_Set__r.Name, Product_Set__r.Total_Price__c, Product_Set__r.Highest_Item_Price__c,
                                        Product_Set__r.Discount__c, Product_Item__r.Name, Product_Item__r.Price__c, Product_Item__r.Category__c
                                        FROM Set_Item__c
                                        WHERE Product_Set__c = : id
                                        ORDER BY Product_Item__r.Name];
        return allDetails;
    }
}