import 'package:flutter/material.dart';
import 'package:shopsmart_users/screens/cart/bottom_checkout.dart';
import 'package:shopsmart_users/screens/cart/cart_widget.dart';
import 'package:shopsmart_users/services/assets_manager.dart';
import 'package:shopsmart_users/widgets/empty_bag.dart';
import 'package:shopsmart_users/widgets/title_text.dart';

class CartScreen extends StatelessWidget {
  const CartScreen({super.key});
  final bool isEmpty = false;
  @override
  Widget build(BuildContext context) {
    return isEmpty
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
            bottomSheet: const CartBottomCheckout(),
            appBar: AppBar(
              title: const TitlesTextWidget(
                label: "Cart (5)",
              ),
              leading: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Image.asset(AssetsManager.shoppingCart),
              ),
              actions: [
                IconButton(
                  onPressed: () {},
                  icon: const Icon(
                    Icons.delete_forever_rounded,
                    color: Colors.red,
                  ),
                ),
              ],
            ),
            body: ListView.builder(
              itemCount: 15,
              itemBuilder: (context, index) {
                return const CartWidget();
              },
            ),
          );
  }
}
