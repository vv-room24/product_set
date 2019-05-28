/**
 * Created by vvermiichuk on 24.05.2019.
 */

public with sharing class PizzaMaker {

    public static void receiptDelimiter(String [] abc) {
        Map <Integer, Set<String>> receipts = new Map<Integer, Set<String>>();
        Map <Integer, Integer> popularReceiptes = new Map<Integer, Integer>();

        for (Integer i = 0; i < (abc.size()); i++) {
            Set <String> ingredients = new Set<String>();
            ingredients.addAll(abc[i].split(','));
            receipts.put(i, ingredients);
//            if (!receipts.values().contains(ingredients)) {
//                receipts.put(i, ingredients);
//            } else {
//                receipts.put(i, ingredients);
//                for(Set <String> val : receipts.values()){
//                    if(receipts.values().contains(ingredients)){
//                        Integer counter = 1;
//                        counter++;
//                        popularReceiptes.put(i, counter);
//                    }
//                }
//                }
            }

            for (Set <String> sett : receipts.values()) {
                Integer counter = 0;
                if (receipts.values().contains(sett)) {
                    counter++;
                    System.debug(receipts.values().indexOf(sett));
                    popularReceiptes.put((receipts.values().indexOf(sett)), counter);
                }
            }



            System.debug(receipts.values());
            System.debug(popularReceiptes.keySet());
            System.debug(popularReceiptes.values());
        }
    }