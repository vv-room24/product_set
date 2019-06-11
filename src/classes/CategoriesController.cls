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

    @AuraEnabled
    public static List <Product_Item__c> avoidProductSetItems(Id selectedProductSet){
        List <Set_Item__c> setItems = CategoriesController.getSetItems();
        List <Product_Item__c> products = CategoriesController.getProductItems();
        List <Product_Item__c> newProducts = new List<Product_Item__c>();
        List <String> avoidedProductNames = new List<String>();
        for (Set_Item__c setItem : setItems) {
            if (setItem.Product_Set__r.Id == selectedProductSet) {
                avoidedProductNames.add(setItem.Product_Item__r.Name);
                }
            }
        for (Integer i = 0; i < products.size(); i++){
            if (!avoidedProductNames.contains(products[i].Name)) {
                newProducts.add(products[i]);
            }
        }
        return newProducts;
    }
}