import 'package:dynamic_height_grid_view/dynamic_height_grid_view.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shopsmart_users/providers/product_provider.dart';
import 'package:shopsmart_users/providers/viewed_prod_provider.dart';
import 'package:shopsmart_users/services/assets_manager.dart';
import 'package:shopsmart_users/services/my_app_method.dart';
import 'package:shopsmart_users/widgets/empty_bag.dart';
import 'package:shopsmart_users/widgets/products/product_widget.dart';
import 'package:shopsmart_users/widgets/title_text.dart';

class ViewedRecentlyScreen extends StatelessWidget {
  const ViewedRecentlyScreen({super.key});
  static const routName = '/ViewedRecentlyScreen';

  @override
  Widget build(BuildContext context) {
    final productProvider = Provider.of<ProductProvider>(context);
    final viewedProdProvider = Provider.of<ViewedProdProvider>(context);

    return viewedProdProvider.getviewedProdItem.isEmpty
        ? Scaffold(
            body: EmptyBagWidget(
              imagePath: AssetsManager.orderBag,
              title: "Your recently is empty",
              subtitle:
                  'Looks like you didn\'t add anything yet to your recently \ngo ahead and start shopping now',
              buttonText: "Shop now",
            ),
          )
        : Scaffold(
            appBar: AppBar(
              title: TitlesTextWidget(
                label:
                    "Viewed recently (${viewedProdProvider.getviewedProdItem.length})",
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
                      subtitle: "Clear History",
                      isError: false,
                      fct: () {
                        viewedProdProvider.clearLocalHistory();
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
            body: Padding(
              padding: const EdgeInsets.all(6.0),
              child: DynamicHeightGridView(
                itemCount: viewedProdProvider.getviewedProdItem.length,
                builder: ((context, index) {
                  return ChangeNotifierProvider.value(
                    value: viewedProdProvider.getviewedProdItem[index],
                    child: ProductWidget(
                      productId: viewedProdProvider.getviewedProdItem.values
                          .toList()
                          .reversed
                          .toList()[index]
                          .productId,
                    ),
                  );
                }),
                crossAxisCount: 2,
              ),
            ),
          );
  }
}
