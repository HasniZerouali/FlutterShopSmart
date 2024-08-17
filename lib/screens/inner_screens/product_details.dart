import 'package:fancy_shimmer_image/fancy_shimmer_image.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shopsmart_users/constants/app_constants.dart';
import 'package:shopsmart_users/providers/theme_provider.dart';
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
    return Scaffold(
      appBar: AppBar(
        //zidd backgrond f them data
        centerTitle: true,
        // automaticallyImplyLeading: false,
        leading: IconButton(
          onPressed: () {
            //zadt canPop bach lamkach haja 9balha matwalich "null"
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
      body: SingleChildScrollView(
        child: Column(
          children: [
            //min image gaya mn internet ndiro FSImage khir
            FancyShimmerImage(
              imageUrl: AppConstants.productImageUrl,
              height: size.height * 0.38,
              width: double.infinity,
              boxFit: BoxFit.contain,
              // errorWidget: , dirha f halat madahratch image
            ),
            const SizedBox(height: 10),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Column(
                children: [
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Flexible(
                        // flex: 5,
                        child: Text(
                          "Title " * 10,
                          style: const TextStyle(
                              fontSize: 20, fontWeight: FontWeight.bold),
                        ),
                      ),
                      const SizedBox(width: 13),
                      const SubtitleTextWidget(
                        label: "166.5\$",
                        fontSize: 22,
                        color: Colors.blue,
                        fontWeight: FontWeight.bold,
                      ),
                    ],
                  ),
                  const SizedBox(height: 25),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 30),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: [
                        HeartButtonWidget(
                          color: themeProvider.getIsDarkTheme
                              ? Color.fromARGB(255, 110, 112, 246)
                              : const Color(0xffc0e9fd),
                        ),
                        const SizedBox(width: 10),
                        Expanded(
                          child: SizedBox(
                            height: kBottomNavigationBarHeight - 10,
                            child: ElevatedButton.icon(
                              style: ElevatedButton.styleFrom(
                                  iconColor:
                                      const Color.fromARGB(255, 146, 109, 250),
                                  backgroundColor: themeProvider.getIsDarkTheme
                                      ? Color.fromARGB(255, 136, 97, 234)
                                      : const Color(0xffeef4fa),
                                  shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(30))),
                              onPressed: () {},
                              label: const Text(
                                "Add to cart",
                                style: TextStyle(
                                    fontWeight: FontWeight.bold, fontSize: 16),
                                // style: TextStyle(color: Colors.white),
                              ),
                              icon: Icon(
                                Icons.add_shopping_cart,
                                color: themeProvider.getIsDarkTheme
                                    ? const Color(0xFFd0bcff)
                                    : const Color(0xff6b55a6),
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(height: 25),
                  const Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      TitlesTextWidget(label: "About this item"),
                      SubtitleTextWidget(label: "In phones")
                    ],
                  ),
                  const SizedBox(height: 25),
                  SubtitleTextWidget(label: "description " * 15),
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}
