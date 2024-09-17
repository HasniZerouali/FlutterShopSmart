import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:iconly/iconly.dart';
import 'package:provider/provider.dart';
import 'package:shopsmart_users/providers/wishlist_provider.dart';
import 'package:shopsmart_users/services/my_app_method.dart';
import 'package:shopsmart_users/widgets/rotating_Indicator_widget.dart';

class HeartButtonWidget extends StatefulWidget {
  const HeartButtonWidget({
    super.key,
    this.size = 22,
    this.color = Colors.transparent,
    required this.productId,
  });
  final double size;
  final Color? color;
  final String productId;

  @override
  State<HeartButtonWidget> createState() => _HeartButtonWidgetState();
}

class _HeartButtonWidgetState extends State<HeartButtonWidget> {
  bool isLoading = false;
  @override
  Widget build(BuildContext context) {
    final wishlistProvider = Provider.of<WishlistProvider>(context);
    // min tasha9 tmodifi wtakhdam bal les function dir WishlistProvider kima hna "addorremove..." wmin tasha9 ri tafichi wla tmad id l cahc consturcur "tsha9 variable ta3 le model" dir wishlistModel Kima LatestArrival
    return Container(
      decoration: BoxDecoration(
        shape: BoxShape.circle,
        color: widget.color,
      ),
      child: IconButton(
        style: IconButton.styleFrom(shape: const CircleBorder()),
        onPressed: () async {
          // log("Wishlist map is : ${wishlistProvider.getWishlistItems}");
          setState(() {
            // wishlistProvider.addOrRemoveFromWishlist(
            //     productId: widget.productId);
            isLoading = true;
          });
          try {
            if (wishlistProvider.getWishlistItems
                .containsKey(widget.productId)) {
              wishlistProvider.removeWishlistItemFromFirebase(
                productId: widget.productId,
                wishlistId:
                    wishlistProvider.getWishlistItems[widget.productId]!.id,
              );
            } else {
              wishlistProvider.addToWishlistFirebase(
                  productId: widget.productId, context: context);
            }
            await wishlistProvider.fetchWishlist();
          } catch (error) {
            MyAppMethods.showErrorORWarningDialog(
                context: context, subtitle: error.toString(), fct: () {});
          } finally {
            setState(() {
              isLoading = false;
            });
          }
        },
        icon: isLoading
            ? const RotatingProgressIndicator()
            : Icon(
                wishlistProvider.isProductInWishlist(
                        productId: widget.productId)
                    ? IconlyBold.heart
                    : IconlyLight.heart,
                size: widget.size,
                color: wishlistProvider.isProductInWishlist(
                        productId: widget.productId)
                    ? Colors.red
                    : null, // Colors.grey or null
                //ndiro widget.size khararch var size 3arafnah khareg l State fi StatfulWidget
              ),
      ),
    );
  }
}
