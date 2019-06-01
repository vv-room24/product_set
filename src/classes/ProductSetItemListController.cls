/**
 * Created by vvermiichuk on 29.05.2019.
 */

public with sharing class ProductSetItemListController {

    @AuraEnabled
    public static List <String> getProductSetItems(Id productSetId){
        List <String> productItemsNames = new List<String>();
        System.debug(productSetId);
        for (Set_Item__c productItem : [SELECT Product_Item__r.Name FROM Set_Item__c WHERE Product_Set__r.Id = : productSetId]){
            productItemsNames.add(productItem.Product_Item__r.Name);

        }
        System.debug(productItemsNames.size());
        return productItemsNames;
    }

    @AuraEnabled
    public static Product_Set__c getDetails(Id id){
        List <Product_Set__c> detail = [SELECT Name, Total_Price__c, Highest_Item_Price__c, Discount__c
                                        FROM Product_Set__c
                                        WHERE Id = :id];
        return detail[0];
    }
}