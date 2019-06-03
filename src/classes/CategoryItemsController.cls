/**
 * Created by vvermiichuk on 30.05.2019.
 */

public with sharing class CategoryItemsController {

    @AuraEnabled
    public static List <String> getProductItemsNames(String category){
        List <String> productItems = new List<String>();
        for (Product_Item__c productItem : [SELECT Name FROM Product_Item__c WHERE Category__c =: category]){
            productItems.add(productItem.Name);
        }
        return productItems;
    }
}