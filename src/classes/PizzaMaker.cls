/**
 * Created by vvermiichuk on 24.05.2019.
 */

public with sharing class PizzaMaker {

    public static void receiptDelimiter(String [] abc){
        Map <Integer, Set<String>> receipts = new Map<Integer, Set<String>>();
        for (Integer i = 0; i < (abc.size()); i++){
            Set <String> ingredients = new Set<String>();
            ingredients.addAll(abc[i].split(','))       ;
            receipts.put(i, ingredients);
        }
        for (Set <String> receipt : receipts.values()){}
//        List <String> ingredients = abc.split(',');
//        for (Integer i = 0; i < (ingredients.size()); i++){
//            String part;
//            part = ingredients.get(i);
//            System.debug(part + '     ' + i);
        }
    }

