/**
 * Created by владимир on 24.05.2019.
 */

@IsTest
private class ProductSetPriceHandlerTest {

    public static List <Set_Item__c> dataForUpdate(){

        Product_Item__c pItem1 = new Product_Item__c(
                Name = 'Gin',
                Price__c = 30,
                Category__c = 'drinks');

        Product_Item__c pItem2 = new Product_Item__c(
                Name = 'Juice',
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

        List <Set_Item__c> testItems = new List<Set_Item__c>();
        testItems.add(sItem1);
        testItems.add(sItem2);
        return testItems;
//
//        insert sItem1;
//        insert sItem2;
    }

    @isTest
    public static void updateTotalPriceTest(){

        Test.startTest();
        List <Set_Item__c> testSetItems = dataForUpdate();
        insert testSetItems;
        Test.stopTest();

        List<Product_Set__c> newProductSet = [SELECT Id, Name, Total_Price__c FROM Product_Set__c WHERE Name = 'TestPSet'];
        System.debug(newProductSet);
        Decimal newTotalPrice = newProductSet[0].Total_Price__c;

        System.assertEquals(55, newTotalPrice);
    }

    @isTest
    public static void updateHighestItemPriceTest(){

        Test.startTest();
        List <Set_Item__c> testSetItems = dataForUpdate();
        insert testSetItems;
        Test.stopTest();

        List<Product_Set__c> newProductSet = [SELECT Id, Highest_Item_Price__c FROM Product_Set__c WHERE Name = 'TestPSet'];
        System.debug(newProductSet);
        Decimal newHighestItemPrice = newProductSet[0].Highest_Item_Price__c;

        System.assertEquals(30, newHighestItemPrice);
    }

    @isTest
    public static void updateDeletedTotalPriceTest(){

        Test.startTest();
        List <Set_Item__c> testSetItems = dataForUpdate();
        insert testSetItems;
        List <Set_Item__c> setItemsForDelete = [SELECT Id FROM Set_Item__c WHERE Name = 'TestSetItem1'];
        delete setItemsForDelete;
        Test.stopTest();

        List<Product_Set__c> newProductSet = [SELECT Id, Name, Total_Price__c FROM Product_Set__c WHERE Name = 'TestPSet'];
        System.debug(newProductSet);
        Decimal newTotalPrice = newProductSet[0].Total_Price__c;

        System.assertEquals(25, newTotalPrice);
    }

    @isTest
    public static void updateDeletedHighestItemPriceTest(){

        Test.startTest();
        List <Set_Item__c> testSetItems = dataForUpdate();
        insert testSetItems;
        List <Set_Item__c> setItemsForDelete = [SELECT Id FROM Set_Item__c WHERE Name = 'TestSetItem1'];
        delete setItemsForDelete;
        Test.stopTest();

        List<Product_Set__c> newProductSet = [SELECT Id, Name, Highest_Item_Price__c FROM Product_Set__c WHERE Name = 'TestPSet'];
        System.debug(newProductSet);
        Decimal newHighestPrice = newProductSet[0].Highest_Item_Price__c;

        System.assertEquals(25, newHighestPrice);
    }
}