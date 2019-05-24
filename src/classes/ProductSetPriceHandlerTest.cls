/**
 * Created by владимир on 24.05.2019.
 */

@IsTest
private class ProductSetPriceHandlerTest {

    @testSetup
    public static void setup(){
        Product_Item__c pItem1 = new Product_Item__c(
                Name = 'Whisky',
                Price__c = 30,
                Category__c = 'drinks');

        Product_Item__c pItem2 = new Product_Item__c(
                Name = 'Rom',
                Price__c = 25,
                Category__c = 'drinks');

        insert pItem1;
        insert pItem2;

        Product_Set__c pSet = new Product_Set__c(Name = 'TestPSet');

        insert pSet;

        Set_Item__c sItem1 = new Set_Item__c(
                Name = 'TestSetItem1',
                Product_Set__c = pSet.Id,
                Product_Item__c = pItem1.Id);

        Set_Item__c sItem2 = new Set_Item__c(
                Name = 'TestSetItem2',
                Product_Set__c = pSet.Id,
                Product_Item__c = pItem2.Id);

        /*List <Set_Item__c> testItems = new List<Set_Item__c>();
        testItems.add(sItem1);
        testItems.add(sItem2);
        insert testItems;*/

        insert sItem1;
        insert sItem2;
    }

    @isTest
    public static void updateTotalPriceTest(){

        Test.startTest();
        ProductSetPriceHandler productSetPriceHandler = new ProductSetPriceHandler(Trigger.new);
        productSetPriceHandler.updateTotalPrice();
        Test.stopTest();

        List<Product_Set__c> newProductSet = [SELECT Id, Total_Price__c FROM Product_Set__c WHERE Name = 'TestPSet'];
        Decimal newTotalPrice = newProductSet[0].Total_Price__c;

        System.assertEquals(newTotalPrice, 55 );
    }

    @isTest
    public static void updateHighestItemPriceTest(){

        Test.startTest();
        ProductSetPriceHandler productSetPriceHandler = new ProductSetPriceHandler(Trigger.new);
        productSetPriceHandler.updateHighestItemPrice();
        Test.stopTest();

        List<Product_Set__c> newProductSet = [SELECT Id, Highest_Item_Price__c FROM Product_Set__c WHERE Name = 'TestPSet'];
        Decimal newTotalPrice = newProductSet[0].Highest_Item_Price__c;

        System.assertEquals(newTotalPrice, 30);
    }
}