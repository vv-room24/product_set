/**
 * Created by владимир on 23.05.2019.
 */

public with sharing class ProductSetPriceHandler {

    List <Set_Item__c> siList;
//    List <Set_Item__c> newPriceList = [SELECT
//            Product_Item__r.Price__c,
//            Product_Set__r.Id,
//            Product_Set__r.Highest_Item_Price__c
//            FROM Set_Item__c];

    public ProductSetPriceHandler(List <Set_Item__c> setItems){
        List <Set_Item__c> retrieveSIList = [SELECT
                                            Product_Set__c,
                                            Product_Item__r.Price__c,
                                            Product_Set__r.Id,
                                            Product_Set__r.Total_Price__c,
                                            Product_Set__r.Highest_Item_Price__c
                                            FROM Set_Item__c
                                            WHERE Id IN :setItems];
        siList = retrieveSIList;
    }

    public void updateTotalPrice(Boolean isDeletedSetItem){
        Boolean isDeleted = isDeletedSetItem;
        Map <Id, Product_Set__c> productSetsToUpdate = new Map <Id, Product_Set__c>();
            for (Set_Item__c setItem : siList){
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
                                (productSetsToUpdate.get(setItem.Product_Set__r.Id).Total_Price__c += setItem.Product_Item__r.Price__c));
                    }
            }
        upsert productSetsToUpdate.values();
    }

    public void updateHighestItemPrice(){
        Map <Id, Product_Set__c> productSetsToUpdate = new Map <Id, Product_Set__c>();
        for (Set_Item__c setItem : siList){
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

    public void updateDeletedHighestItemPrice(List <Set_Item__c> setItems){
//        Map <Id, Product_Set__c> productSetsToUpdate = new Map <Id, Product_Set__c>();
//        for (Set_Item__c setItem : newPriceList){
//            setItem.Product_Set__r.Highest_Item_Price__c = 0;
//            if(setItem.Product_Set__r.Highest_Item_Price__c < setItem.Product_Item__r.Price__c){
//                if(!productSetsToUpdate.containsKey(setItem.Product_Set__r.Id)) {
//                    Product_Set__c ps = new Product_Set__c(
//                            Id = setItem.Product_Set__r.Id,
//                            Highest_Item_Price__c = setItem.Product_Item__r.Price__c
//                    );
//                    productSetsToUpdate.put(ps.Id, ps);
//                }else{
//                    if (productSetsToUpdate.get(setItem.Product_Set__r.Id).Highest_Item_Price__c < setItem.Product_Item__r.Price__c) {
//                        setItem.Product_Set__r.Highest_Item_Price__c = setItem.Product_Item__r.Price__c;
//                    }
//                }
//            }
//        }
//        upsert productSetsToUpdate.values();

        List <Id> setItemsIds = new List<Id>();
        for (Set_Item__c setItem : setItems){
            setItemsIds.add(setItem.Product_Set__c);
        }

        Map <Id, Product_Set__c> productSetsToUpdate2 = new Map <Id, Product_Set__c>([SELECT Highest_Item_Price__c,
                                                                                        (SELECT Product_Item__r.Price__c
                                                                                        FROM Unique_Sets__r
                                                                                        )
                                                                                        FROM Product_Set__c
                                                                                        WHERE Id IN : setItemsIds
                                                                                      ]);
        List <Product_Set__c> productSets = productSetsToUpdate2.values();
        for (Integer i = 0; i < productSets.size(); i++) {
            Decimal highest = 0;
            for (Integer j = 0; j < productSets[i].Unique_Sets__r.size(); j++) {
                if (highest < productSets[i].Unique_Sets__r[j].Product_Item__r.Price__c) {
                    highest = productSets[i].Unique_Sets__r[j].Product_Item__r.Price__c;
                }
            }
            productSets[i].Highest_Item_Price__c = highest;
        }
        update productSets;


    }
}