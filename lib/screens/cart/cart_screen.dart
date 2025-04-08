import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shopsmart_users/providers/cart_provider.dart';
import 'package:shopsmart_users/providers/product_provider.dart';
import 'package:shopsmart_users/providers/user_provider.dart';
import 'package:shopsmart_users/screens/cart/bottom_checkout.dart';
import 'package:shopsmart_users/screens/cart/cart_widget.dart';
import 'package:shopsmart_users/screens/loading_manager.dart';
import 'package:shopsmart_users/services/assets_manager.dart';
import 'package:shopsmart_users/services/my_app_method.dart';
import 'package:shopsmart_users/widgets/empty_bag.dart';
import 'package:shopsmart_users/widgets/title_text.dart';
import 'package:uuid/uuid.dart';

class CartScreen extends StatefulWidget {
  const CartScreen({super.key});

  @override
  State<CartScreen> createState() => _CartScreenState();
}

class _CartScreenState extends State<CartScreen> {
  // final bool isEmpty = false;
  bool isLoading = false;
  @override
  Widget build(BuildContext context) {
    final cartProvider = Provider.of<CartProvider>(context);
    final userProvider = Provider.of<UserProvider>(context, listen: false);
    final productProvider =
        Provider.of<ProductProvider>(context, listen: false);

    return cartProvider.getCartItems.isEmpty
        ? Scaffold(
            body: EmptyBagWidget(
              imagePath: AssetsManager.shoppingBasket,
              title: "Your cart is empty",
              subtitle:
                  'Looks like you didn\'t add anything yet to your cart \ngo ahead and start shopping now',
              buttonText: "Shop now",
            ),
          )
        : Scaffold(
            bottomSheet: CartBottomCheckout(
              function: () async {
                await placeOrder(
                  cartProvider: cartProvider,
                  productProvider: productProvider,
                  userProvider: userProvider,
                );
              },
            ),
            appBar: AppBar(
              title: TitlesTextWidget(
                label: "Cart (${cartProvider.getCartItems.length})",
              ),
              leading: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Image.asset(AssetsManager.shoppingCart),
              ),
              actions: [
                IconButton(
                  onPressed: () {
                    MyAppMethods.showErrorORWarningDialog(
                      context: context,
                      subtitle: "Remove items",
                      isError: false,
                      fct: () async {
                        await cartProvider.clearCartFromFirebase();
                        // cartProvider.clearLocalCart();
                      },
                    );
                  },
                  icon: const Icon(
                    Icons.delete_forever_rounded,
                    color: Colors.red,
                  ),
                ),
              ],
            ),
            body: LoadingManager(
              isLoading: isLoading,
              child: Column(children: [
                Expanded(
                  child: ListView.builder(
                    itemCount: cartProvider.getCartItems.length,
                    itemBuilder: (context, index) {
                      return ChangeNotifierProvider.value(
                        value: cartProvider.getCartItems.values
                            .toList()
                            .reversed // bach item jdid dirah malfog
                            .toList()[index],
                        child: CartWidget(),
                      );
                    },
                  ),
                ),
                SizedBox(
                  height: kBottomNavigationBarHeight + 10,
                )
              ]),
            ),
          );
  }

  Future<void> placeOrder({
    required CartProvider cartProvider,
    required ProductProvider productProvider,
    required UserProvider userProvider,
  }) async {
    final auth = FirebaseAuth.instance;
    User? user = auth.currentUser;
    if (user == null) {
      return;
    }
    final uid = user.uid;
    try {
      setState(() {
        isLoading = false;
      });
      cartProvider.getCartItems.forEach((key, value) async {
        final getCurrProduct = productProvider.findByProdId(value.productId);
        final orderId = Uuid().v4();
        await FirebaseFirestore.instance
            .collection("ordersAdvanced")
            .doc(orderId)
            .set({
          'orderId': orderId,
            'userId': uid,
          'productId': value.productId,
          "productTitle": getCurrProduct!.productTitle,
          'price': double.parse(getCurrProduct.productPrice) * value.quantity,
          'totalPrice': cartProvider.getTotal(productProvider: productProvider),
          'quantity': value.quantity,
          'imageUrl': getCurrProduct.productImage,
          'userName': userProvider.getUserModel!.userName,
          //hna 9ader yasra problem kon user ydrk fhad botona 9bal mayrof l profileScreen tama kono fazal madarna fetchUserInfo() bach njibo l info , tama lhal radi nzidha fal RootScreen
          'orderDate': Timestamp.now(),
        });
      });
      await cartProvider.clearCartFromFirebase();
      cartProvider.clearLocalCart();
    } catch (e) {
      MyAppMethods.showErrorORWarningDialog(
        context: context,
        //hna masha9itch nmadalha context fal paramater khatarch rana fal State ta3 class
        subtitle: e.toString(),
        fct: () {},
      );
    } finally {
      setState(() {
        isLoading = false;
      });
    }
  }
}
