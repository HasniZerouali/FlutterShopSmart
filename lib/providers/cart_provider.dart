import 'dart:developer';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:shopsmart_users/models/cart_model.dart';
import 'package:shopsmart_users/models/product_model.dart';
import 'package:shopsmart_users/providers/product_provider.dart';
import 'package:shopsmart_users/services/my_app_method.dart';
import 'package:uuid/uuid.dart';

class CartProvider with ChangeNotifier {
  //nzidoh  fal main
  final Map<String, CartModel> _cartItems = {};
  Map<String, CartModel> get getCartItems {
    return _cartItems;
  }

// Firebase
  final usersDB = FirebaseFirestore.instance.collection("users");
  final _auth = FirebaseAuth.instance;
  Future<void> addToCartFirebase(
      {required String productId,
      required int qty,
      required BuildContext context}) async {
    final User? user = _auth.currentUser;
    if (user == null) {
      MyAppMethods.showErrorORWarningDialog(
          context: context, subtitle: "please log in", fct: () {});
      return;
    }
    final uid = user.uid;
    final cartId = const Uuid().v4();
    try {
      usersDB.doc(uid).update({
        'userCart': FieldValue.arrayUnion([
          {
            "cartId": cartId,
            'productId': productId,
            'quantity': qty,
          }
        ]),
      });
      await fetchCart(); //min yzidhom fal firebase nzidohom fal cart tani bhadi func
      Fluttertoast.showToast(msg: "Item has been added to cart");
    } catch (e) {
      rethrow;
    }
  }

  Future<void> fetchCart() async {
    //9iyam li fal firebase dirgom fal Map hnaya
    User? user = _auth.currentUser;
    if (user == null) {
      log("mack the cart null");
      _cartItems.clear();
      return;
    }
    try {
      final userDoc = await usersDB.doc(user.uid).get();
      final data = userDoc.data(); // raja3ha map
      if (data == null || !data.containsKey("userCart")) {
        // ida kana fal firebase makach line samoha "userCart" dir had if
        return;
      }
      // tnjm dir for kima ta3 fechProducts
      final leng = userDoc.get("userCart").length;
      for (int index = 0; index < leng; index++) {
        _cartItems.putIfAbsent(
            userDoc.get("userCart")[index]['productId'],
            () => CartModel(
                  cartId: userDoc.get("userCart")[index]['cartId'],
                  productId: userDoc.get("userCart")[index]['productId'],
                  quantity: userDoc.get("userCart")[index]['quantity'],
                ));
      }
    } catch (e) {
      rethrow;
    }
    notifyListeners();
  }

  Future<void> clearCartFromFirebase() async {
    User? user = _auth.currentUser;
    try {
      await usersDB.doc(user!.uid).update({
        "userCart": [],
      });
      _cartItems.clear();
    } catch (e) {
      rethrow;
    }
    notifyListeners();
  }

  Future<void> removeCartItemFromFirebase(
      {required String cartId,
      required String productId,
      required int qty}) async {
    User? user = _auth.currentUser;
    try {
      await usersDB.doc(user!.uid).update({
        'userCart': FieldValue.arrayRemove([
          {
            "cartId": cartId,
            'productId': productId,
            'quantity': qty,
          }
        ]),
      });
      _cartItems.remove(
          productId); //najmo nagal3o hadi remove khatrch fetchCart() broha tmodifi _cartItems
      await fetchCart(); // This will automatically update _cartItems
    } catch (e) {
      rethrow;
    }
    notifyListeners();
  }  

  // Local

  bool isProductInCart({required String productId}) {
    return _cartItems.containsKey(productId);
  }

  void addProductToCart({required String productId}) {
    _cartItems.putIfAbsent(
      productId,
      () => CartModel(
          cartId: const Uuid().v4(), productId: productId, quantity: 1),
    );
    //"putIfAbsent" id kana had key mawjod madtzidch had valeu
    notifyListeners();
// bach natsama3 3la tarayorat li yasraw w nmodifihom kima "setState()" , (notifyListenners) lazam class tkon (with ChangeNotifier)
  }

  void updateQuantity({required String productId, required int quantity}) {
    _cartItems.update(
      productId,
      (item) => CartModel(
        cartId: item.cartId,
        productId: productId, //tnajam dir item.productId
        quantity: quantity,
      ),
    );
    //"putIfAbsent" id kana had key mawjod madtzidch had valeu
    notifyListeners();
  }

  double getTotal({required ProductProvider productProvider}) {
    double total = 0.0;
    _cartItems.forEach((key, value) {
      final ProductModel? getCurrProduct =
          productProvider.findByProdId(value.productId);
      if (getCurrProduct == null) {
        total += 0;
      } else {
        total += double.parse(getCurrProduct.productPrice) * value.quantity;
      }
    });
    return total;
  }

  int getQty() {
    int total = 0;
    _cartItems.forEach((key, value) {
      total += value.quantity;
    });
    return total;
  }

  void removeOneItem({required String productId}) {
    _cartItems.remove(productId);
    notifyListeners();
  }

  void clearLocalCart() {
    _cartItems.clear();
    notifyListeners();
  }
}
