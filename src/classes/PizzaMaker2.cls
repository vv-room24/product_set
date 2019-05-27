/**
 * Created by vvermiichuk on 27.05.2019.
 */

public with sharing class PizzaMaker2 {
    public static void receiptDelimiter(String [] receiptList) {
        Map <Set<String>, Integer> receipts = new Map<Set<String>, Integer>();
        for (Integer i = 0; i < (receiptList.size()); i++) {
            Set <String> ingredients = new Set<String>();
            ingredients.addAll(receiptList[i].split(','));
            if(!receipts.containsKey(ingredients)){
                receipts.put(ingredients, 1);
            }
            else {
                receipts.put(ingredients, (receipts.get(ingredients) + 1));
            }
        }

        System.debug(receipts);
        System.debug(receipts.keySet());

    }
}