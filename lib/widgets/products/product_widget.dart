import 'package:fancy_shimmer_image/fancy_shimmer_image.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shopsmart_users/constants/app_constants.dart';
import 'package:shopsmart_users/models/product_model.dart';
import 'package:shopsmart_users/providers/product_provider.dart';
import 'package:shopsmart_users/providers/theme_provider.dart';
import 'package:shopsmart_users/screens/inner_screens/product_details.dart';
import 'package:shopsmart_users/widgets/products/heart_btn.dart';
import 'package:shopsmart_users/widgets/subtitle_text.dart';
import 'package:shopsmart_users/widgets/title_text.dart';

class ProductWidget extends StatefulWidget {
  //  lazam ykon fal paren lisiner, yatsama3 3la tarayorat (lal productModel)

  const ProductWidget({
    super.key,
    required this.productId,
    // this.image,
    // this.title,
    // this.price,
  });

  final String productId;

  // final String? image, title, price;
  @override
  State<ProductWidget> createState() => _ProductWidgetState();
}

class _ProductWidgetState extends State<ProductWidget> {
  @override
  Widget build(BuildContext context) {
    // final productModelProvider = Provider.of<ProductModel>(context);
    final productProvider = Provider.of<ProductProvider>(context);

    final getCurrProduct = productProvider.findByProdId(widget.productId);

    Size size = MediaQuery.of(context).size;
    return getCurrProduct == null
        ? SizedBox.shrink()
        : Padding(
            padding: const EdgeInsets.all(3.0),
            child: GestureDetector(
              onTap: () async {
                // liana typ ta3 pushNamed Fututr dir async await
                await Navigator.pushNamed(context, ProductDetails.routName);
              },
              child: Column(
                children: [
                  ClipRRect(
                    borderRadius: BorderRadius.circular(30),
                    child: FancyShimmerImage(
                      imageUrl: getCurrProduct.productImage,
                      // widget.image
                      //ndiro widget.image liana image fi statful bara hadi class
                      // ?? AppConstants.productImageUrl,
                      //dart ?? ma3naha id image==null tawari hadi taswira
                      width: double.infinity,
                      height: size.height * 0.22,
                    ),
                  ),
                  const SizedBox(height: 15),
                  Row(
                    children: [
                      Flexible(
                        flex: 5,
                        child: TitlesTextWidget(
                          fontSize: 18,
                          label: getCurrProduct.productTitle,
                          maxLines: 2,
                        ),
                      ),
                      const Flexible(
                        flex: 2,
                        child: HeartButtonWidget(),
                      )
                    ],
                  ),
                  const SizedBox(height: 15),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 5),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Flexible(
                          flex: 3,
                          child: SubtitleTextWidget(
                            label: "${getCurrProduct.productPrice}\$",
                          ),
                        ),
                        Flexible(
                          child: Material(
                            borderRadius: BorderRadius.circular(16),
                            color: Color.fromARGB(255, 176, 147, 250),
                            child: InkWell(
                              borderRadius: BorderRadius.circular(16),
                              onTap: () {},
                              child: const Padding(
                                padding: EdgeInsets.all(8.0),
                                child: Icon(
                                  Icons.add_shopping_cart_rounded,
                                  size: 20,
                                ),
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(height: 10),
                ],
              ),
            ),
          );
  }
}
