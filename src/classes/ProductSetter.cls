/**
 * Created by vvermiichuk on 22.05.2019.
 */

public with sharing class ProductSetter {

    static Map <Id, Set_Item__c> productSIMap = new Map <Id, Set_Item__c>([SELECT Id, Product_Item__r.Price__c
                                                                    FROM  Set_Item__c]);
    static Map <Id, Set_Item__c> SIMap = new Map <Id, Set_Item__c>([SELECT Id, Product_Set__r.Id
                                                                    FROM  Set_Item__c]);
    static Map <Id, Product_Set__c> PSMap = new Map <Id, Product_Set__c>([SELECT Id, Total_Price__c
                                                                    FROM  Product_Set__c]);

    public static void updateTotalPrice(List <Set_Item__c> siItems) {
        for (Set_Item__c siItem: siItems){
            
            SIMap.get(siItem.Id).Product_Set__r.Total_Price__c += productSIMap.get(siItem.Id).Product_Item__r.Price__c;

        }
    }
}
