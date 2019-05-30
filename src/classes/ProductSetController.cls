/**
 * Created by vvermiichuk on 30.05.2019.
 */

public with sharing class ProductSetController {

    @AuraEnabled
    public static String getProductSetName(Id productSetId){
        String productSetName;
        List <String> names = new List<String>();
        for (Product_Set__c name : [SELECT Name FROM Product_Set__c WHERE Id = : productSetId]){
            names.add(name.Name);
        }
        productSetName = names.get(0);
        return productSetName;
    }

    @AuraEnabled
    public static Decimal getProductSetTotalPrice(Id productSetId){
        Decimal totalPrice;
        for (Product_Set__c namePrice : [SELECT Total_Price__c FROM Product_Set__c WHERE Id = : productSetId]){
            totalPrice = namePrice.Total_Price__c;
        }
        return totalPrice;
    }

}