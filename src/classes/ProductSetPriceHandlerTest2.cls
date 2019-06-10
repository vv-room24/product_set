/**
 * Created by vvermiichuk on 10.06.2019.
 */

@IsTest
private class ProductSetPriceHandlerTest2 {

    public static List<Set_Item__c> getSetItems(){

        List <Product_Item__c> productItems = [SELECT Name, Price__c FROM Product_Item__c];
        List <Set_Item__c> setItems = new List<Set_Item__c>();
        List <Product_Set__c> productSets = [SELECT Name, Total_Price__c, Highest_Item_Price__c FROM Product_Set__c];

        for (Integer i = 0; i < productItems.size(); i++){
            Set_Item__c setItem = new Set_Item__c();
            setItem.Name = 'TestSetItem' + i;
            setItem.Product_Item__c = productItems[i].Id;
            setItem.Product_Set__c = productSets[0].Id;
            setItems.add(setItem);
        }
        return setItems;
    }

    @IsTest
    static void testInsertSetItems() {

        Test.startTest();
        insert getSetItems();
        Test.stopTest();

        List <AggregateResult> productPrices = [SELECT SUM(Price__c)total FROM Product_Item__c ];
        System.debug(productPrices);
        Object total = productPrices[0].get('total');
        System.debug(total);
        List <Set_Item__c> setItems = [SELECT Name, Product_Set__r.Total_Price__c, Product_Set__r.Highest_Item_Price__c
                                        FROM Set_Item__c WHERE Name = 'TestSetItem0'];
        Decimal totDecimal = setItems[0].Product_Set__r.Total_Price__c;
        System.debug(totDecimal);

    }
}