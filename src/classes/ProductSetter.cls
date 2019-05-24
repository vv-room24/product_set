/**
 * Created by vvermiichuk on 22.05.2019.
 */

public with sharing class ProductSetter {

    static Map <Id, Set_Item__c> productSIMap = new Map <Id, Set_Item__c>();
    static Map <Id, Product_Set__c> setMap = new Map <Id, Product_Set__c>();
    static Map <Id, Product_Set__c> setHighPriceMap = new Map <Id, Product_Set__c>();
    static List <Set_Item__c> siItems;

    public ProductSetter(List <Set_Item__c> items) {
        productSIMap = new Map <Id, Set_Item__c>([SELECT Id, Product_Item__r.Price__c
                                                FROM Set_Item__c WHERE Id IN :siItems]);
        setMap = new Map <Id, Product_Set__c>([SELECT Id, Total_Price__c
                                            FROM Product_Set__c]);
        setHighPriceMap = new Map <Id, Product_Set__c>([SELECT Id, Highest_Item_Price__c
                                                    FROM Product_Set__c]);
        siItems = items;
    }

    public void updateTotalPrice() {
        for (Set_Item__c siItem: siItems){

            Decimal price = productSIMap.get(siItem.Id).Product_Item__r.Price__c;
            setMap.get(siItem.Product_Set__r.Id).Total_Price__c += price;
        }
        update setMap.values();
    }

    public void updateHighestItemPrice(){
        for (Set_Item__c siItem: siItems){
            Decimal price = productSIMap.get(siItem.Id).Product_Item__r.Price__c;
            if (price > siItem.Product_Set__r.Highest_Item_Price__c) {
                siItem.Product_Set__r.Highest_Item_Price__c = price;
                setHighPriceMap.get(siItem.Product_Set__r.Id).Highest_Item_Price__c = price;
            }
        }
        update setHighPriceMap.values();
    }
}