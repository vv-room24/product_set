public with sharing class ProductSetUpdateHandler {

    public static void updateTotalPrice(){

        List<Set_Item__c> setItems = [SELECT Id, Product_Item__c, Product_Set__c FROM Set_Item__c];
        List<Product_Set__c> productSetList = [SELECT Id, Total_Price__c FROM Product_Set__c];
        List<Product_Item__c> productItemList = [SELECT Id, Price__c FROM Product_Item__c];

        for (Product_Set__c productSet : productSetList){
            Decimal count = 0;
        	for(Set_Item__c setItem: setItems){        	
                if (productSet.Id == setItem.Product_Set__c){					                 
                	for (Product_Item__c productItem : productItemList){
                		if (productItem.Id == setItem.Product_Item__c){       
                            count += productItem.Price__c;                        	
                        }                     
                }                
            } 
            }
            productSet.Total_Price__c = count;
        }
        update productSetList;
    }
    
    public static void updateHighestItemPrice(){

        List<Set_Item__c> setItems = [SELECT Id, Product_Item__c, Product_Set__c FROM Set_Item__c];
        List<Product_Set__c> productSetList = [SELECT Id, Highest_Item_Price__c FROM Product_Set__c]; 
        List<Product_Item__c> productItemList = [SELECT Id, Price__c FROM Product_Item__c];
        
        for (Product_Set__c productSet : productSetList){
            Decimal max = 0;
            Decimal count = 0;
        	for(Set_Item__c setItem: setItems){        	
                if (productSet.Id == setItem.Product_Set__c){					                 
                	for (Product_Item__c productItem : productItemList){
                		if (productItem.Id == setItem.Product_Item__c){       
                            count = productItem.Price__c;
                            if (count > max){
                            	max += count;
                            }
                        }                     
                }                
            } 
            }
            productSet.Highest_Item_Price__c = max;
        }
        update productSetList;
}
}