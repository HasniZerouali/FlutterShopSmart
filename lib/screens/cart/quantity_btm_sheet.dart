import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shopsmart_users/models/cart_model.dart';
import 'package:shopsmart_users/widgets/subtitle_text.dart';

import '../../providers/cart_provider.dart';

class QuantityBottomSheetWidget extends StatelessWidget {
  const QuantityBottomSheetWidget({
    super.key,
    required this.cartModel,
  });
  final CartModel cartModel;

  @override
  Widget build(BuildContext context) {
    final cartProvider = Provider.of<CartProvider>(context);
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Column(
        children: [
          const SizedBox(height: 15),
          Container(
            height: 6,
            width: 50,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(12.0),
              color: Colors.grey.withOpacity(0.5),
            ),
          ),
          const SizedBox(height: 15),
          Expanded(
            child: ListView.builder(
              //bach tnjm dirha dakhal column dir bsh makach scrol tarika 1 : w zid dir column fi singl..Scrol.
              // shrinkWrap: true,
              // physics: NeverScrollableScrollPhysics(),
              //tarika taniya dirha fi expended
              itemCount: 22,
              itemBuilder: (BuildContext context, int index) {
                return InkWell(
                  //bach twali btm w tani kayn GestureDetector
                  onTap: () {
                    cartProvider.updateQuantity(
                        productId: cartModel.productId, quantity: (index + 1));
                    Navigator.pop(context);
                  },
                  child: Padding(
                    padding: const EdgeInsets.all(3.0),
                    child: Center(
                      child: SubtitleTextWidget(
                        label: "${index + 1}",
                      ),
                    ),
                  ),
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}
