/**
 * Created by vvermiichuk on 05.06.2019.
 */

public with sharing class CategoriesController {

    @AuraEnabled
    public static List <Product_Item__c> getProductItems(){
        List <Product_Item__c> products = [SELECT Name, Category__c FROM Product_Item__c];
        return products;
    }
}