import 'package:fancy_shimmer_image/fancy_shimmer_image.dart';
import 'package:flutter/material.dart';
import 'package:iconly/iconly.dart';
import 'package:shopsmart_users/constants/app_constants.dart';
import 'package:shopsmart_users/screens/cart/quantity_btm_sheet.dart';
import 'package:shopsmart_users/widgets/products/heart_btn.dart';
import 'package:shopsmart_users/widgets/subtitle_text.dart';
import 'package:shopsmart_users/widgets/title_text.dart';

class CartWidget extends StatelessWidget {
  const CartWidget({super.key});

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;

    return FittedBox(
      //hado (IntrinsicWidth,FittedBox)bach matakhraj bar safra 3la jal blass

      child: IntrinsicWidth(
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Row(
            children: [
              ClipRRect(
                borderRadius: BorderRadius.circular(12),
                child: FancyShimmerImage(
                  //ydir animation bilama tatla3 l photo
                  imageUrl: AppConstants.productImageUrl,
                  height: size.height * 0.2,
                  width: size.width * 0.2,
                ),
              ),
              const SizedBox(width: 12),
              IntrinsicWidth(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        SizedBox(
                          width: size.width * 0.6,
                          child: TitlesTextWidget(
                            label: "label" * 10,
                            maxLines: 2,
                          ),
                        ),
                        Column(
                          children: [
                            IconButton(
                              onPressed: () {},
                              icon: const Icon(
                                Icons.clear,
                                color: Colors.red,
                              ),
                            ),
                            const HeartButtonWidget(),
                          ],
                        ),
                      ],
                    ),
                    Row(
                      children: [
                        const SubtitleTextWidget(
                          label: "16\$",
                          fontSize: 20,
                          color: Colors.blue,
                        ),
                        const Spacer(),
                        OutlinedButton.icon(
                          style: OutlinedButton.styleFrom(
                            shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(30)),
                            side: const BorderSide(
                                width: 1,
                                color: Color.fromARGB(255, 165, 144, 218)),
                          ),
                          onPressed: () async {
                            await showModalBottomSheet(
                                backgroundColor:
                                    Theme.of(context).scaffoldBackgroundColor,
                                shape: const RoundedRectangleBorder(
                                    borderRadius: BorderRadius.only(
                                  topLeft: Radius.circular(16),
                                  topRight: Radius.circular(16),
                                )),
                                context: context,
                                builder: (context) {
                                  return const QuantityBottomSheetWidget();
                                });
                          },
                          label: const Text(
                            "Qty: 6",
                            style: TextStyle(
                                color: Color.fromARGB(255, 165, 144, 218),
                                fontWeight: FontWeight.bold),
                          ),
                          icon: const Icon(
                            IconlyLight.arrow_down_2,
                            color: Color.fromARGB(255, 165, 144, 218),
                          ),
                        ),
                      ],
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
