import 'package:fancy_shimmer_image/fancy_shimmer_image.dart';
import 'package:flutter/material.dart';
import 'package:shopsmart_users/constants/app_constants.dart';
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
      body: Column(
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
                        color: Colors.blue.shade300,
                      ),
                      const SizedBox(width: 10),
                      Expanded(
                        child: SizedBox(
                          height: kBottomNavigationBarHeight - 10,
                          child: ElevatedButton.icon(
                            style: ElevatedButton.styleFrom(
                                iconColor:
                                    const Color.fromARGB(255, 139, 97, 255),
                                backgroundColor:
                                    const Color.fromARGB(255, 226, 212, 249),
                                shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(30))),
                            onPressed: () {},
                            label: const Text(
                              "Add to cart",
                              // style: TextStyle(color: Colors.white),
                            ),
                            icon: const Icon(Icons.add_shopping_cart),
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
    );
  }
}
