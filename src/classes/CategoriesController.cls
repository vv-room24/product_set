/**
 * Created by vvermiichuk on 05.06.2019.
 */

public with sharing class CategoriesController {

    @AuraEnabled
    public static List <Product_Item__c> getProductItems(){
        List <Product_Item__c> products = [SELECT Name, Category__c FROM Product_Item__c];
        return products;
    }

    @AuraEnabled
    public static List <Set_Item__c> getSetItems(){
        List <Set_Item__c> setItems = [SELECT Name, Product_Item__c, Product_Set__c,
                                        Product_Item__r.Name, Product_Item__r.Price__c, Product_Item__r.Category__c,
                                        Product_Set__r.Name, Product_Set__r.Total_Price__c, Product_Set__r.Highest_Item_Price__c, Product_Set__r.Discount__c
                                        FROM Set_Item__c];
        return setItems;
    }
}