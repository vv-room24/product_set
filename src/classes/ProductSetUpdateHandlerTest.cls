@isTest
public class ProductSetUpdateHandlerTest {
    @isTest
    public static void updateTotalPriceTest(){        
        
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
        
        Decimal totalPrice = (pItem1.Price__c + pItem2.Price__c);
        
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
        
        insert sItem1;
        insert sItem2;
        
        Test.startTest();    	
        	ProductSetUpdateHandler.updateTotalPrice();
    	Test.stopTest();
        
        List<Product_Set__c> newProductSet = [SELECT Id, Total_Price__c FROM Product_Set__c WHERE Id = :pSet.Id];
        Decimal newTotalPrice = newProductSet[0].Total_Price__c;
     
    	System.assertEquals(newTotalPrice, totalPrice );
    }
    
   	@isTest
    public static void updateHighestItemPriceTest(){
        
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
        
        Decimal high = pItem1.Price__c;
        
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
        
        insert sItem1;
        insert sItem2;
        
        Test.startTest();    	
        	ProductSetUpdateHandler.updateHighestItemPrice();
    	Test.stopTest();  
        
        List<Product_Set__c> newProductSet = [SELECT Id, Highest_Item_Price__c FROM Product_Set__c WHERE Id = :pSet.Id];
        Decimal newTotalPrice = newProductSet[0].Highest_Item_Price__c;
     
    	System.assertEquals(newTotalPrice, high);        
    }

}