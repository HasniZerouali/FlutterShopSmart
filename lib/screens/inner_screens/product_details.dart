import 'package:fancy_shimmer_image/fancy_shimmer_image.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shopsmart_users/constants/app_constants.dart';
import 'package:shopsmart_users/providers/cart_provider.dart';
import 'package:shopsmart_users/providers/product_provider.dart';
import 'package:shopsmart_users/providers/theme_provider.dart';
import 'package:shopsmart_users/services/my_app_method.dart';
import 'package:shopsmart_users/widgets/app_name_text.dart';
import 'package:shopsmart_users/widgets/products/heart_btn.dart';
import 'package:shopsmart_users/widgets/subtitle_text.dart';
import 'package:shopsmart_users/widgets/title_text.dart';

class ProductDetails extends StatefulWidget {
  //3arif rowt bach dir Navigation
  static const routName = '/ProductDetails';
  const ProductDetails({super.key});

  @override
  State<ProductDetails> createState() => _ProductDetailsState();
}

class _ProductDetailsState extends State<ProductDetails> {
  @override
  Widget build(BuildContext context) {
    final themeProvider = Provider.of<ThemeProvider>(context);

    Size size = MediaQuery.of(context).size; // ma3rifat ab3ad a chacha

    final productProvider =
        Provider.of<ProductProvider>(context, listen: false);
    final productId = ModalRoute.of(context)!.settings.arguments as String;

    final getCurrProduct = productProvider.findByProdId(productId);
    final cartProvider = Provider.of<CartProvider>(context);

    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        leading: IconButton(
          onPressed: () {
            Navigator.canPop(context) ? Navigator.pop(context) : null;
          },
          icon: const Icon(
            Icons.arrow_back_ios,
            size: 18,
          ),
        ),
        title: const AppNameTextWidget(
          fontSize: 20,
        ),
      ),
      body: getCurrProduct == null
          ? const SizedBox.shrink()
          : SingleChildScrollView(
              child: Padding(
                padding:
                    const EdgeInsets.symmetric(horizontal: 22, vertical: 8.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    FancyShimmerImage(
                      imageUrl: getCurrProduct.productImage,
                      height: size.height * 0.38,
                      width: double.infinity,
                      boxFit: BoxFit.cover,
                      // You can add errorWidget here for graceful error handling.
                    ),
                    const SizedBox(height: 10),
                    Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Flexible(
                          child: Text(
                            getCurrProduct.productTitle,
                            style: const TextStyle(
                                fontSize: 20, fontWeight: FontWeight.bold),
                          ),
                        ),
                        const SizedBox(width: 13),
                        HeartButtonWidget(
                          productId: getCurrProduct.productId,
                          color: themeProvider.getIsDarkTheme
                              ? const Color.fromARGB(255, 110, 112, 246)
                              : const Color(0xffc0e9fd),
                        ),
                      ],
                    ),
                    const SizedBox(height: 25),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        const TitlesTextWidget(label: "About this item"),
                        SubtitleTextWidget(
                            label: "In ${getCurrProduct.productCategory}")
                      ],
                    ),
                    const SizedBox(height: 25),
                    SubtitleTextWidget(
                        label: getCurrProduct.productDescription),
                    const SizedBox(height: 25),
                    // Nutritional information card at the bottom
                    const NutritionalInfoCard(),
                  ],
                ),
              ),
            ),
    );
  }
}

class NutritionalInfoCard extends StatelessWidget {
  const NutritionalInfoCard({Key? key}) : super(key: key);

  Widget buildNutritionalRow(String label, String value) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 4.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            label,
            style: const TextStyle(fontSize: 16, fontWeight: FontWeight.w500),
          ),
          Text(
            value,
            style: const TextStyle(fontSize: 16, fontWeight: FontWeight.w500),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 4,
      margin: const EdgeInsets.symmetric(horizontal: 0, vertical: 16),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(12),
      ),
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              'Nutritional Information',
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 8),
            buildNutritionalRow('Additive', 'E255'),
            buildNutritionalRow('Fat per 100g', '12g'),
            buildNutritionalRow('Sugar per 100g', '8g'),
            buildNutritionalRow('Salt per 100g', '1.2g'),
            buildNutritionalRow('Sodium per 100g', '480mg'),
            buildNutritionalRow('Energy per 100g', '220 kcal'),
            buildNutritionalRow('Protein per 100g', '3.5g'),
            buildNutritionalRow('Fibre per 100g', '4g'),
          ],
        ),
      ),
    );
  }
}
