/**
 * Created by vvermiichuk on 28.05.2019.
 */

public with sharing class ProductSetListController {

    @AuraEnabled
    public static List <Map<String, String>> getProductSets(){
        List <Map<String, String>> productSets = new List<Map<String, String>>();
        for (Product_Set__c productSet : [SELECT Name FROM Product_Set__c]){
            productSets.add(new Map<String, String>{'value' => productSet.Id, 'label' => productSet.Name});
        }
        return productSets;
    }

    @AuraEnabled
    public static void createNewSet(String name){
        Product_Set__c newProductSet = new Product_Set__c(
                Name = name,
                Total_Price__c = 0,
                Highest_Item_Price__c = 0
        );
        insert newProductSet;
    }
}