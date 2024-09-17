import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';

import 'package:shopsmart_users/models/wishlist_model.dart';
import 'package:shopsmart_users/services/my_app_method.dart';
import 'package:uuid/uuid.dart';

class WishlistProvider with ChangeNotifier {
  //nzidoh  fal main
  final Map<String, WishlistModel> _wishlistItems = {};
  Map<String, WishlistModel> get getWishlistItems {
    return _wishlistItems;
  }

// Firebase
  final usersDB = FirebaseFirestore.instance.collection("users");
  final _auth = FirebaseAuth.instance;
  Future<void> addToWishlistFirebase(
      {required String productId, required BuildContext context}) async {
    final User? user = _auth.currentUser;
    if (user == null) {
      MyAppMethods.showErrorORWarningDialog(
          context: context, subtitle: "please log in", fct: () {});
      return;
    }
    final uid = user.uid;
    final wishlistId = const Uuid().v4();
    try {
      usersDB.doc(uid).update({
        'userWish': FieldValue.arrayUnion([
          {
            "wishlistId": wishlistId,
            'productId': productId,
          }
        ]),
      });
      // await fetchWishlist(); //min yzidhom fal firebase nzidohom fal cart tani bhadi func
      Fluttertoast.showToast(msg: "Item has been added to Wishlist");
    } catch (e) {
      rethrow;
    }
  }

  Future<void> fetchWishlist() async {
    //9iyam li fal firebase dirhom fal Map hnaya
    User? user = _auth.currentUser;
    if (user == null) {
      // log("mack the cart null");
      _wishlistItems.clear();
      return;
    }
    try {
      final userDoc = await usersDB.doc(user.uid).get();
      final data = userDoc.data(); // raja3ha map
      if (data == null || !data.containsKey("userWish")) {
        // ida kana fal firebase makach line samoha "userWish" dir had if
        return;
      }
      // tnjm dir for kima ta3 fechProducts
      final leng = userDoc.get("userWish").length;
      for (int index = 0; index < leng; index++) {
        _wishlistItems.putIfAbsent(
          userDoc.get("userWish")[index]['productId'],
          () => WishlistModel(
            id: userDoc.get("userWish")[index]['wishlistId'],
            productId: userDoc.get("userWish")[index]['productId'],
          ),
        );
      }
    } catch (e) {
      rethrow;
    }
    notifyListeners();
  }

  Future<void> clearWishlistFromFirebase() async {
    User? user = _auth.currentUser;
    try {
      await usersDB.doc(user!.uid).update({
        "userWish": [],
      });
      _wishlistItems.clear();
    } catch (e) {
      rethrow;
    }
    notifyListeners();
  }

  Future<void> removeWishlistItemFromFirebase({
    required String wishlistId,
    required String productId,
  }) async {
    User? user = _auth.currentUser;
    try {
      await usersDB.doc(user!.uid).update({
        'userWish': FieldValue.arrayRemove([
          {
            "wishlistId": wishlistId,
            'productId': productId,
          }
        ]),
      });
      _wishlistItems.remove(
          productId); //najmo nagal3o hadi remove khatrch fetchCart() broha tmodifi _cartItems
      // await fetchCart(); // This will automatically update _cartItems
    } catch (e) {
      rethrow;
    }
    notifyListeners();
  }

// Local

  bool isProductInWishlist({required String productId}) {
    return _wishlistItems.containsKey(productId);
  }

  void addOrRemoveFromWishlist({required String productId}) {
    if (isProductInWishlist(productId: productId)) {
      _wishlistItems.remove(productId);
    } else {
      _wishlistItems.putIfAbsent(
        productId,
        () => WishlistModel(
          id: const Uuid().v4(),
          productId: productId,
        ),
      );
      //"putIfAbsent" id kana had key mawjod madtzidch had valeu

// bach natsama3 3la tarayorat li yasraw w nmodifihom kima "setState()" , (notifyListenners) lazam class tkon (with ChangeNotifier)
    }
    notifyListeners();
  }

  void clearLocalWishlist() {
    _wishlistItems.clear();
    notifyListeners();
  }
}
