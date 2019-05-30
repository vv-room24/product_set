/**
 * Created by vvermiichuk on 30.05.2019.
 */

public with sharing class CategoryListController {

    @AuraEnabled
    public static List <String> getCategories(){
        List <String> categories = new List<String>();
        for (Product_Item__c category : [SELECT Category__c FROM Product_Item__c ]){
            if(!categories.contains(category.Category__c)) {
                categories.add(category.Category__c);
            }
        }
        return categories;
    }

    @AuraEnabled
    public static List <String> getProductItemsNames(String category){
        List <String> productItems = new List<String>();
        for (Product_Item__c productItem : [SELECT Name FROM Product_Item__c WHERE Category__c =: category]){
            productItems.add(productItem.Name);
        }
        return productItems;
    }

//    @AuraEnabled
//    public static List <String> getProducts(){
////        List <Product_Item__c> products = new List<Product_Item__c>();
////        for (Product_Item__c product : [SELECT Name, Category__c FROM Product_Item__c ]){
////            if(!products.contains(category.Category__c)) {
////                categories.add(category.Category__c);
////            }
////        }
////        return categories;
//    }
}

