import 'package:fancy_shimmer_image/fancy_shimmer_image.dart';
import 'package:flutter/material.dart';
import 'package:shopsmart_users/constants/app_constants.dart';
import 'package:shopsmart_users/screens/inner_screens/product_details.dart';
import 'package:shopsmart_users/widgets/products/heart_btn.dart';
import 'package:shopsmart_users/widgets/subtitle_text.dart';
import 'package:shopsmart_users/widgets/title_text.dart';

class ProductWidget extends StatefulWidget {
  const ProductWidget({super.key});

  @override
  State<ProductWidget> createState() => _ProductWidgetState();
}

class _ProductWidgetState extends State<ProductWidget> {
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Padding(
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
                imageUrl: AppConstants.productImageUrl,
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
                    label: "title" * 10,
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
                  const Flexible(
                    flex: 3,
                    child: SubtitleTextWidget(
                      label: "166.5\$",
                    ),
                  ),
                  Flexible(
                    child: Material(
                      borderRadius: BorderRadius.circular(16),
                      color: Colors.lightBlue,
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
