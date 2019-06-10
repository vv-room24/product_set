/**
 * Created by vvermiichuk on 10.06.2019.
 */

@IsTest
private class ProductSetPriceHandlerTest2 {

    static void getSetItems(){

        Product_Set__c testProductSet = new Product_Set__c(Name = 'TestProductSet', Total_Price__c = 0, Highest_Item_Price__c = 0);
        insert testProductSet;
        List <Product_Item__c> testProductItems = new List<Product_Item__c>();
        for (Integer i = 0; i < 10; i++){
            Product_Item__c testProductItem = new Product_Item__c(Name = 'drink ' + i, Price__c = i*10, Category__c = 'drinks');
            testProductItems.add(testProductItem);
        }
        insert testProductItems;
        for (Integer i = 0; i < testProductItems.size(); i++){
            Set_Item__c setItem = new Set_Item__c(Name = 'TestSetItem ' + i, Product_Set__c = testProductSet.Id, Product_Item__c = testProductItems[i].Id);
            insert setItem;
        }
    }

    @IsTest
    static void testInsertSetItems() {

        Test.startTest();
            ProductSetPriceHandlerTest2.getSetItems();
        Test.stopTest();

        List <Set_Item__c> eItems = [SELECT Name, Product_Set__c FROM Set_Item__c WHERE Name = 'TestSetItem 0'];
        System.debug(eItems[0].Name);
    }
}