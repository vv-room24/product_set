/**
 * Created by владимир on 23.05.2019.
 */

public with sharing class ProductSetPriceHandler {

    List <Set_Item__c> siList;

    public ProductSetPriceHandler(List <Set_Item__c> setItems){
        List <Set_Item__c> retrieveSIList = [SELECT
                                            Product_Item__r.Price__c,
                                            Product_Set__r.Id,
                                            Product_Set__r.Total_Price__c,
                                            Product_Set__r.Highest_Item_Price__c
                                            FROM Set_Item__c
                                            WHERE Id IN :setItems];
        siList = retrieveSIList;
    }

    public void updateTotalPrice(){
        Map <Id, Product_Set__c> productSetsToUpdate = new Map <Id, Product_Set__c>();
        for (Set_Item__c setItem : siList){
            if(!productSetsToUpdate.containsKey(setItem.Product_Set__r.Id)) {
                try {
                    Product_Set__c ps = new Product_Set__c(
                            Id = setItem.Product_Set__r.Id,
                            Total_Price__c = (setItem.Product_Set__r.Total_Price__c + setItem.Product_Item__r.Price__c)
                    );
                    productSetsToUpdate.put(ps.Id, ps);
                }catch (Exception e){System.debug(e.getStackTraceString());}
                }
            else {
                productSetsToUpdate.get(setItem.Product_Set__r.Id).Total_Price__c += setItem.Product_Item__r.Price__c;
            }
        }
        upsert productSetsToUpdate.values();
    }

    public void updateHighestItemPrice() {
        Map <Id, Product_Set__c> productSetsToUpdate = new Map <Id, Product_Set__c>();
        for (Set_Item__c setItem : siList){
            if(!productSetsToUpdate.containsKey(setItem.Product_Set__r.Id)) {
                if (setItem.Product_Item__r.Price__c > setItem.Product_Set__r.Highest_Item_Price__c) {
                    Product_Set__c ps = new Product_Set__c(
                            Id = setItem.Product_Set__r.Id,
                            Highest_Item_Price__c = setItem.Product_Item__r.Price__c
                    );
                    productSetsToUpdate.put(ps.Id, ps);
                }
            }
            else {
                productSetsToUpdate.get(setItem.Product_Set__r.Id).Highest_Item_Price__c = setItem.Product_Item__r.Price__c;
            }
        }
        upsert productSetsToUpdate.values();
    }
}