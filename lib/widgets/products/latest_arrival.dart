import 'package:fancy_shimmer_image/fancy_shimmer_image.dart';
import 'package:flutter/material.dart';
import 'package:shopsmart_users/constants/app_constants.dart';
import 'package:shopsmart_users/screens/inner_screens/product_details.dart';
import 'package:shopsmart_users/widgets/products/heart_btn.dart';
import 'package:shopsmart_users/widgets/subtitle_text.dart';

class LatestArrivalProductsWidget extends StatelessWidget {
  const LatestArrivalProductsWidget({super.key});

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;

    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: GestureDetector(
        onTap: () async {
          // liana typ ta3 pushNamed Fututr dir async await
          await Navigator.pushNamed(context, ProductDetails.routName);
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
                    imageUrl: AppConstants.productImageUrl,
                    width: size.height * 0.28,
                    height: size.height * 0.28,
                  ),
                ),
              ),
              const SizedBox(width: 7),
              Flexible(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      "eeH" * 10,
                      maxLines: 2,
                      overflow: TextOverflow.ellipsis,
                    ),
                    FittedBox(
                      //bach tagla3 barr safra "overflow" aw flexible
                      child: Row(
                        children: [
                          const HeartButtonWidget(
                            size: 18,
                          ),
                          IconButton(
                            onPressed: () {},
                            icon: const Icon(
                              Icons.add_shopping_cart_rounded,
                              size: 18,
                            ),
                          ),
                        ],
                      ),
                    ),
                    const FittedBox(
                      //bach maykonch kayen overflow
                      child: SubtitleTextWidget(
                        label: "166.5\$",
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
