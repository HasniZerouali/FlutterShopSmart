import 'package:dynamic_height_grid_view/dynamic_height_grid_view.dart';
import 'package:flutter/material.dart';
import 'package:shopsmart_users/services/assets_manager.dart';
import 'package:shopsmart_users/widgets/empty_bag.dart';
import 'package:shopsmart_users/widgets/products/product_widget.dart';
import 'package:shopsmart_users/widgets/title_text.dart';

class WishlistScreen extends StatelessWidget {
  const WishlistScreen({super.key});
  static const routName = '/WishlistScreen';

  final bool isEmpty = true;
  @override
  Widget build(BuildContext context) {
    return isEmpty
        ? Scaffold(
            body: EmptyBagWidget(
              imagePath: AssetsManager.bagWish,
              title: "Your wishlist is empty",
              subtitle:
                  'Looks like you didn\'t add anything yet to your wishlist \ngo ahead and start shopping now',
              buttonText: "Shop now",
            ),
          )
        : Scaffold(
            appBar: AppBar(
              title: const TitlesTextWidget(
                label: "Wishlist (5)",
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
            body: DynamicHeightGridView(
              itemCount: 20,
              builder: ((context, index) {
                return const ProductWidget();
              }),
              crossAxisCount: 2,
            ),
          );
  }
}
