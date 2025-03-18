import 'dart:math';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:grocery_store/keys/auth_keys.dart';
import 'package:grocery_store/keys/firebase_collections_keys.dart';
import 'package:grocery_store/models/address.dart';
import 'package:grocery_store/models/grocery_items_model.dart';
import 'package:grocery_store/models/mannual_data.dart';
import 'package:grocery_store/models/purchasedItems.dart';
import 'package:shared_preferences/shared_preferences.dart';

class GroceryListFireStore extends Equatable {
  final CollectionReference _groceriesObj = FirebaseFirestore.instance
      .collection("users");
  List<dynamic> _groceryListToAddItems = [];
  List<dynamic> _addressList = [];
  List<dynamic> _groceryListToMannualAddItems = [];
  final List<Item> _groceryListToGetItems = [];
  final List<ManualData> _groceryListManualGetItems = [];

  void saveGroceryToDataBase({required Item items}) async {
    print(items);
    SharedPreferences sharePref = await SharedPreferences.getInstance();
    final uId = sharePref.getString(AuthKeys.USER_ID);
    final document = _groceriesObj
        .doc(uId)
        .collection(
          FirebaseCollectionsKeys.groceryItemsCollectionId.toString(),
        );

    try {
      DocumentSnapshot<Map<String, dynamic>> isDocExists =
          await document
              .doc(FirebaseCollectionsKeys.groceryItemsDocumentId)
              .get();

              print("exsist: ${isDocExists.exists}");

      if (isDocExists.exists) {
        print("_groceryListToAddItems ${_groceryListToAddItems.isEmpty}");
        _groceryListToAddItems = isDocExists.data()!["items"];
        _groceryListToAddItems.add(items.toJson());
        print(_groceryListToAddItems);
        await document.doc(FirebaseCollectionsKeys.groceryItemsDocumentId).set({
          "items":_groceryListToAddItems
        });
      } else {
        await document.doc(FirebaseCollectionsKeys.groceryItemsDocumentId).set({
          "items": _groceryListToAddItems
        });
      }
    } catch (e) {
      throw Exception(e);
    }
  }

    Future<List<Item>> getDataFromDataBase() async {
      SharedPreferences sharePref = await SharedPreferences.getInstance();
      final uId = sharePref.getString(AuthKeys.USER_ID);
   List data = [];
      try {
        final document = _groceriesObj.doc(uId).collection(
            FirebaseCollectionsKeys.groceryItemsCollectionId.toString());

        DocumentSnapshot<Map<String, dynamic>> dataSnapShot = await document
            .doc(FirebaseCollectionsKeys.groceryItemsDocumentId)
            .get();

            if(dataSnapShot.data() != null){
                  data = await dataSnapShot.data()!["items"];
            }

        if (data.isEmpty) {
          return [];
        } else {
          for (var ele in data) {
            _groceryListToGetItems.add(Item.fromJson(ele));
          }
          // print(newList.runtimeType);
        }
        return _groceryListToGetItems;
      } catch (e) {
        debugPrintStack();
        throw Exception(e);
      }
    }

 void saveManualNardCodeData({required ManualData items}) async {

    SharedPreferences sharePref = await SharedPreferences.getInstance();
    final uId = sharePref.getString(AuthKeys.USER_ID);
    final document = _groceriesObj
        .doc(uId)
        .collection(
          FirebaseCollectionsKeys.groceryMannualCollectionId.toString(),
        );

    try {
      DocumentSnapshot<Map<String, dynamic>> isDocExists =
          await document
              .doc(FirebaseCollectionsKeys.groceryMannualDocumentId)
              .get();

              print("exsist: ${isDocExists.exists}");

      if (isDocExists.exists) {
        print("_groceryListToAddItems ${_groceryListToMannualAddItems.isEmpty}");
        _groceryListToMannualAddItems = isDocExists.data()!["data"];
        _groceryListToMannualAddItems.add(items.toJson());
        print(_groceryListToMannualAddItems);
        await document.doc(FirebaseCollectionsKeys.groceryMannualDocumentId).set({
          "data":_groceryListToMannualAddItems
        });
      } else {
        await document.doc(FirebaseCollectionsKeys.groceryMannualDocumentId).set({
          "data": _groceryListToMannualAddItems
        });
      }
    } catch (e) {
      throw Exception(e);
    }
  }

   Future<ManualData?> getManualDataFromDataBase(String code) async {
      SharedPreferences sharePref = await SharedPreferences.getInstance();
      final uId = sharePref.getString(AuthKeys.USER_ID);
   List data = [];
      try {
        final document = _groceriesObj.doc(uId).collection(
            FirebaseCollectionsKeys.groceryMannualCollectionId.toString());

        DocumentSnapshot<Map<String, dynamic>> dataSnapShot = await document
            .doc(FirebaseCollectionsKeys.groceryMannualDocumentId)
            .get();

            if(dataSnapShot.data() != null){
                  data = await dataSnapShot.data()!["data"];
            }




          var finalData;
        if (data.isEmpty) {
        return null;
        } else {
        for (var i = 0; i < data.length; i++) {
          if(data[i]["code"]==code.toString()){
            finalData =   ManualData.fromJson(data[i]);
          }
        }
          // print(newList.runtimeType);
        }
        return finalData;
      } catch (e) {
        debugPrintStack();
        throw Exception(e);
      }
    }

 void saveAddressToDataBase({required Address items}) async {
    print(items);
    SharedPreferences sharePref = await SharedPreferences.getInstance();
    final uId = sharePref.getString(AuthKeys.USER_ID);
    final document = _groceriesObj
        .doc(uId)
        .collection(
          FirebaseCollectionsKeys.addressCollectionId.toString(),
        );

    try {
      DocumentSnapshot<Map<String, dynamic>> isDocExists =
          await document
              .doc(FirebaseCollectionsKeys.addressDocumentId)
              .get();

              print("exsist: ${isDocExists.exists}");

      if (isDocExists.exists) {
        print("_groceryListToAddItems ${_addressList.isEmpty}");
        _addressList = isDocExists.data()!["address"];
        _addressList.add(items.toMap());
        print(_addressList);
        await document.doc(FirebaseCollectionsKeys.addressDocumentId).set({
          "address":_addressList
        });
      } else {
        await document.doc(FirebaseCollectionsKeys.addressDocumentId).set({
          "address": _addressList
        });
      }
    } catch (e) {
      throw Exception(e);
    }
  }


  @override
  List<Object?> get props => [
    _groceryListToGetItems,
    _groceryListToAddItems,
    _groceriesObj,
    _groceryListToMannualAddItems
  ];
}

