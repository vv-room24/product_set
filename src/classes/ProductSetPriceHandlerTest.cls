/**
 * Created by vvermiichuk on 10.06.2019.
 */

@IsTest
private class ProductSetPriceHandlerTest {

    static List <Set_Item__c> getSetItems(){

        Product_Set__c testProductSet = new Product_Set__c(Name = 'TestProductSet', Total_Price__c = 0, Highest_Item_Price__c = 0);
        insert testProductSet;
        List <Product_Item__c> testProductItems = new List<Product_Item__c>();
        for (Integer i = 0; i < 10; i++){
            Product_Item__c testProductItem = new Product_Item__c(Name = 'drink ' + i, Price__c = i*10, Category__c = 'drinks');
            testProductItems.add(testProductItem);
        }
        insert testProductItems;

        List <Set_Item__c> setItems = new List<Set_Item__c>();
        for (Integer i = 0; i < testProductItems.size(); i++){
            Set_Item__c setItem = new Set_Item__c(Name = 'TestSetItem ' + i, Product_Set__c = testProductSet.Id, Product_Item__c = testProductItems[i].Id);
            setItems.add(setItem);
            insert setItem;
        }
        return setItems;
    }

    @IsTest
    static void testInsertSetItems() {

        Test.startTest();
            ProductSetPriceHandlerTest.getSetItems();
        Test.stopTest();

        List <AggregateResult> setItemsResult = [SELECT Product_Set__c,
                                                MAX(Product_Item__r.Price__c)maxPrice,
                                                MAX(Product_Set__r.Highest_Item_Price__c)highest,
                                                SUM(Product_Item__r.Price__c)sumPrice,
                                                MAX(Product_Set__r.Total_Price__c)totalPrice
                                                FROM Set_Item__c
                                                GROUP BY Product_Set__c];

        Decimal maxPrice = (Decimal)setItemsResult[0].get('maxPrice');
        Decimal highest = (Decimal)setItemsResult[0].get('highest');
        Decimal sumPrice = (Decimal)setItemsResult[0].get('sumPrice');
        Decimal totalPrice = (Decimal)setItemsResult[0].get('totalPrice');

        System.assertEquals(maxPrice, highest);
        System.debug(maxPrice + '---' + highest);
        System.assertEquals(sumPrice, totalPrice);
        System.debug(sumPrice + '---' + totalPrice);
    }

    @isTest
    static void testDeleteSetItems(){

        List <Set_Item__c> setItems = ProductSetPriceHandlerTest.getSetItems();
        List <Set_Item__c> deletedSetItems = new List<Set_Item__c>();
        for(Integer i = setItems.size() - 1; i > (setItems.size())/2; i--){
            deletedSetItems.add(setItems[i]);
        }

        Test.startTest();
            delete deletedSetItems;
        Test.stopTest();

        List <AggregateResult> setItemsResult = [SELECT Product_Set__c,
                                                MAX(Product_Item__r.Price__c)maxPrice,
                                                MAX(Product_Set__r.Highest_Item_Price__c)highest,
                                                SUM(Product_Item__r.Price__c)sumPrice,
                                                MAX(Product_Set__r.Total_Price__c)totalPrice
                                                FROM Set_Item__c
                                                GROUP BY Product_Set__c];

        Decimal maxPrice = (Decimal)setItemsResult[0].get('maxPrice');
        Decimal highest = (Decimal)setItemsResult[0].get('highest');
        Decimal sumPrice = (Decimal)setItemsResult[0].get('sumPrice');
        Decimal totalPrice = (Decimal)setItemsResult[0].get('totalPrice');

        System.assertEquals(maxPrice, highest);
        System.debug(maxPrice + '---' + highest);
        System.assertEquals(sumPrice, totalPrice);
        System.debug(sumPrice + '---' + totalPrice);
    }
}