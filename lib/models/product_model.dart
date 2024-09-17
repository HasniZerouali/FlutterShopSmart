import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class ProductModel with ChangeNotifier {
  final String productId,
      productTitle,
      productPrice,
      productCategory,
      productDescription,
      productImage,
      productQuantity;
  Timestamp? createdAT;
  ProductModel({
    required this.productId,
    required this.productTitle,
    required this.productPrice,
    required this.productCategory,
    required this.productDescription,
    required this.productImage,
    required this.productQuantity,
    this.createdAT,
  });

  factory ProductModel.fromFirestore(DocumentSnapshot doc) {
    //ndiro factory constactur khir (from json to json) , najmnir kima dart m3a userProvider, wtani njm ndir kima drt fal user taha9o9 id kayna wla null" userDocDict.containsKey("userWish") ? userDoc.get("userWish") : [],"

    // na9ra l map ta3 kol Item
    Map data = doc.data() as Map<String, dynamic>; //.data()  traja3ha map
    return ProductModel(
      productId: data['productId'], //doc.get("productId"),
      productTitle: data['productTitle'],
      productPrice: data['productPrice'],
      productCategory: data['productCategory'],
      productDescription: data['productDescription'],
      productImage: data['productImage'],
      productQuantity: data['productQuantity'],
      createdAT: data['createdAt'],
    );
  }
}
