import 'package:flutter/material.dart';
import 'package:shopsmart_users/models/viewed_prod_model.dart';

import 'package:shopsmart_users/models/wishlist_model.dart';
import 'package:uuid/uuid.dart';

class ViewedProdProvider with ChangeNotifier {
  //nzidoh  fal main
  final Map<String, ViewedProdModel> _viewedProdItem = {};
  Map<String, ViewedProdModel> get getviewedProdItem {
    return _viewedProdItem;
  }

  // bool isProductInWishlist({required String productId}) {
  //   return _viewedProdItem.containsKey(productId);
  // }

  void addProductToHistory({required String productId}) {
    _viewedProdItem.putIfAbsent(
      productId,
      () => ViewedProdModel(
        id: const Uuid().v4(),
        productId: productId,
      ),
    );
    //"putIfAbsent" id kana had key mawjod madtzidch had valeu

// bach natsama3 3la tarayorat li yasraw w nmodifihom kima "setState()" , (notifyListenners) lazam class tkon (with ChangeNotifier)

    notifyListeners();
  }

  void clearLocalHistory() {
    _viewedProdItem.clear();
    notifyListeners();
  }
}
