/**
 * Created by vvermiichuk on 28.05.2019.
 */

public with sharing class ProductSetListController {

    @AuraEnabled
    public static List <Map<String, String>> getProductSets(){
        List <Map<String, String>> productSets = new List<Map<String, String>>();
        for (Product_Set__c productSet : [SELECT Name FROM Product_Set__c ORDER BY Name ASC]){
            productSets.add(new Map<String, String>{'value' => productSet.Id, 'label' => productSet.Name});
        }
        return productSets;
    }

}