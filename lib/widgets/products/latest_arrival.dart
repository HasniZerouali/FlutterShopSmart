import 'package:fancy_shimmer_image/fancy_shimmer_image.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shopsmart_users/constants/app_constants.dart';
import 'package:shopsmart_users/models/product_model.dart';
import 'package:shopsmart_users/providers/cart_provider.dart';
import 'package:shopsmart_users/providers/viewed_prod_provider.dart';
import 'package:shopsmart_users/screens/inner_screens/product_details.dart';
import 'package:shopsmart_users/services/my_app_method.dart';
import 'package:shopsmart_users/widgets/products/heart_btn.dart';
import 'package:shopsmart_users/widgets/subtitle_text.dart';

class LatestArrivalProductsWidget extends StatelessWidget {
  const LatestArrivalProductsWidget({super.key});

  @override
  Widget build(BuildContext context) {
    final productModel = Provider.of<ProductModel>(context);
    final cartProvider = Provider.of<CartProvider>(context);
    final viewedProdProvider = Provider.of<ViewedProdProvider>(context);
    Size size = MediaQuery.of(context).size;

    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: GestureDetector(
        onTap: () async {
          // liana typ ta3 pushNamed Fututr dir async await
          viewedProdProvider.addProductToHistory(
              productId: productModel.productId);
          await Navigator.pushNamed(
            context,
            ProductDetails.routName,
            arguments: productModel.productId,
          );
        },
        child: SizedBox(
          width: size.width * 0.45,
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Flexible(
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(8),
                  child: FancyShimmerImage(
                    // color: Colors.red,
                    imageUrl: productModel.productImage,
                    width: size.height * 0.28,
                    height: size.height * 0.28, boxFit: BoxFit.contain,
                  ),
                ),
              ),
              const SizedBox(width: 7),
              Flexible(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      productModel.productTitle,
                      maxLines: 2,
                      overflow: TextOverflow.ellipsis,
                    ),
                    FittedBox(
                      //bach tagla3 barr safra "overflow" aw flexible
                      child: Row(
                        children: [
                          HeartButtonWidget(
                            productId: productModel.productId,
                            size: 18,
                          ),
                          IconButton(
                            onPressed: () async{
                            if (cartProvider.isProductInCart(
                                    productId: productModel.productId)) {
                                  return;
                                }

                                // cartProvider.addProductToCart(
                                //     productId: getCurrProduct.productId);
                                try {
                                  await cartProvider.addToCartFirebase(
                                      productId: productModel.productId,
                                      qty: 1,
                                      context: context);
                                } catch (errror) {
                                  MyAppMethods.showErrorORWarningDialog(
                                      context: context,
                                      subtitle: errror.toString(),
                                      fct: () {});
                                }
                            },
                            icon: Icon(
                              cartProvider.isProductInCart(
                                      productId: productModel.productId)
                                  ? Icons.check
                                  : Icons.add_shopping_cart_rounded,
                              size: 18,
                            ),
                          ),
                        ],
                      ),
                    ),
                    FittedBox(
                      //bach maykonch kayen overflow
                      child: SubtitleTextWidget(
                        label: "${productModel.productPrice}\$",
                        color: Colors.blue,
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
