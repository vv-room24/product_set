/**
 * Created by владимир on 23.05.2019.
 */

public with sharing class ProductSetPriceHandler {

    List <Set_Item__c> setItemList;
    List <AggregateResult> setItemsResults;
    public ProductSetPriceHandler(List <Set_Item__c> setItems){
        List <Set_Item__c> retrievedSetItems = [SELECT
                                            Product_Set__c,
                                            Product_Item__r.Price__c,
                                            Product_Set__r.Id,
                                            Product_Set__r.Total_Price__c,
                                            Product_Set__r.Highest_Item_Price__c
                                            FROM Set_Item__c
                                            WHERE Id IN :setItems];
        setItemList = retrievedSetItems;

        Set <Id> setItemsIds = new Set<Id>();
        for (Set_Item__c setItem : setItems){
            setItemsIds.add(setItem.Product_Set__c);
        }

        List <AggregateResult> setItemsResult = [SELECT Product_Set__c,
                                            MAX(Product_Item__r.Price__c)price,
                                            MAX(Product_Set__r.Highest_Item_Price__c)highest
                                            FROM Set_Item__c
                                            WHERE Product_Set__r.Id IN : setItemsIds
                                            GROUP BY Product_Set__c];

        setItemsResults = setItemsResult;
    }

    public void updateTotalPrice(Boolean isDeletedSetItem){
        Boolean isDeleted = isDeletedSetItem;
        Map <Id, Product_Set__c> productSetsToUpdate = new Map <Id, Product_Set__c>();
        for (Set_Item__c setItem : setItemList){
            if(!productSetsToUpdate.containsKey(setItem.Product_Set__r.Id)) {
                Product_Set__c productSet = new Product_Set__c(
                        Id = setItem.Product_Set__r.Id,
                        Total_Price__c = ((isDeleted)?
                                (setItem.Product_Set__r.Total_Price__c - setItem.Product_Item__r.Price__c):
                                (setItem.Product_Set__r.Total_Price__c + setItem.Product_Item__r.Price__c))
                );
                productSetsToUpdate.put(productSet.Id, productSet);
            }
            else {
                productSetsToUpdate.get(setItem.Product_Set__r.Id).Total_Price__c = ((isDeleted)?
                        (productSetsToUpdate.get(setItem.Product_Set__r.Id).Total_Price__c - setItem.Product_Item__r.Price__c):
                        (productSetsToUpdate.get(setItem.Product_Set__r.Id).Total_Price__c + setItem.Product_Item__r.Price__c));
            }
        }
        upsert productSetsToUpdate.values();
    }

    public void updateHighestItemPrice(){
        Map <Id, Product_Set__c> productSetsToUpdate = new Map <Id, Product_Set__c>();
        for (Set_Item__c setItem : setItemList){
            if(setItem.Product_Set__r.Highest_Item_Price__c < setItem.Product_Item__r.Price__c){
                if(!productSetsToUpdate.containsKey(setItem.Product_Set__r.Id)) {
                    Product_Set__c ps = new Product_Set__c(
                            Id = setItem.Product_Set__r.Id,
                            Highest_Item_Price__c = setItem.Product_Item__r.Price__c
                    );
                    productSetsToUpdate.put(ps.Id, ps);
                }else{
                    if (productSetsToUpdate.get(setItem.Product_Set__r.Id).Highest_Item_Price__c < setItem.Product_Item__r.Price__c) {
                        setItem.Product_Set__r.Highest_Item_Price__c = setItem.Product_Item__r.Price__c;
                    }
                }
            }
        }
        upsert productSetsToUpdate.values();
    }

    public void updateDeletedHighestItemPrice(){
        Map <Id, Product_Set__c> productSetsToUpdate = new Map <Id, Product_Set__c>();
        for (Integer i = 0; i < setItemsResults.size(); i++){
            if ((Decimal)setItemsResults[i].get('price') < (Decimal)setItemsResults[i].get('highest')){
                Product_Set__c ps = new Product_Set__c(
                        Id = (Id)setItemsResults[i].get('Product_Set__c'),
                        Highest_Item_Price__c = (Decimal)setItemsResults[i].get('price')
                );
                productSetsToUpdate.put(ps.Id, ps);
            }
        }
        upsert productSetsToUpdate.values();
    }
}