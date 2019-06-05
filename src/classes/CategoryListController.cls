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
    public static List <String> getProductItems(){
        List <String> categoryItems = new List<String>();
        List <Product_Item__c> productItems = [SELECT Name FROM Product_Item__c];
        for (Product_Item__c productItem : productItems){
            categoryItems.add(productItem.Name);
        }
        return categoryItems;
    }


}

