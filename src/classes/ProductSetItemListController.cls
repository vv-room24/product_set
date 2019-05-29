/**
 * Created by vvermiichuk on 29.05.2019.
 */

public with sharing class ProductSetItemListController {

    @AuraEnabled
    public static List <String> getProductSetItems(Id productSetId){
        List <String> productItemsNames = new List<String>();
        for (Set_Item__c productItem : [SELECT Product_Item__r.Name FROM Set_Item__c WHERE Product_Set__r.Id = : productSetId]){
            productItemsNames.add(productItem.Product_Item__r.Name);
        }
        return productItemsNames;
    }
}