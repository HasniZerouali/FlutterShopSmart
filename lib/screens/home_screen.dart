import 'package:card_swiper/card_swiper.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shopsmart_users/constants/app_constants.dart';
import 'package:shopsmart_users/providers/product_provider.dart';
import 'package:shopsmart_users/services/assets_manager.dart';
import 'package:shopsmart_users/widgets/app_name_text.dart';
import 'package:shopsmart_users/widgets/products/ctg_rounded_widget.dart';
import 'package:shopsmart_users/widgets/products/latest_arrival.dart';
import 'package:shopsmart_users/widgets/title_text.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    final productProvider = Provider.of<ProductProvider>(context);
    // nasta3mil l provider
    // (context, listen: true) listen min dereh true ywali provider yatsama3
    // final themeProvider = Provider.of<ThemeProvider>(context);
    return Scaffold(
      // backgroundColor: AppColors.lightScaffoldColor,
      appBar: AppBar(
        //zidd backgrond f them data

        title: const AppNameTextWidget(
          fontSize: 20,
        ),
        leading: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Image.asset(AssetsManager.shoppingCart),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 12),
        child: SingleChildScrollView(
          child: Column(
            // mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(
                height: size.height * 0.24,
                child: ClipRRect(
                  //bach ndirha mdawra
                  borderRadius: const BorderRadius.only(
                    topLeft: Radius.circular(12),
                    topRight: Radius.circular(12),
                  ),
                  child: Swiper(
                    itemBuilder: (BuildContext context, int index) {
                      return Image.asset(
                        AppConstants.bannersImages[index],
                        fit: BoxFit.fill,
                      );
                    },
                    autoplay: true,
                    itemCount: AppConstants.bannersImages.length,
                    pagination: const SwiperPagination(
                      alignment: Alignment.bottomCenter,
                      builder: DotSwiperPaginationBuilder(
                        // color: Colors.white,
                        activeColor: Colors.purple,
                      ),
                    ),
                  ),
                ),
              ),
              const SizedBox(height: 18),
              const TitlesTextWidget(
                label: "Latest arrival",
                fontSize: 22,
              ),
              const SizedBox(height: 18),
              SizedBox(
                height: size.height * 0.2,
                child: ListView.builder(
                  scrollDirection: Axis.horizontal,
                  itemCount: productProvider.getProducts.length,
                  itemBuilder: (context, index) {
                    return ChangeNotifierProvider.value(
                        value: productProvider.getProducts[index],
                        //fi had screen min nasha9 ga3 listPruduct provider nakhadmo bal class Product Provider , wnmadu lproduct fal value lal class LatesAraival.. w fiha nakahdmo bal typ ta3 product li howa productModel
                        child: LatestArrivalProductsWidget());
                  },
                ),
              ),
              const SizedBox(height: 18),
              const TitlesTextWidget(
                label: "Categories",
                fontSize: 22,
              ),
              const SizedBox(height: 18),
              GridView.count(
                shrinkWrap: true,
                physics: const NeverScrollableScrollPhysics(),
                crossAxisCount: (size.width > 360) ? 4 : 3,
                children:
                    List.generate(AppConstants.categoriesList.length, (index) {
                  return CategoryRoundedWidget(
                      image: AppConstants.categoriesList[index].image,
                      name: AppConstants.categoriesList[index].name);
                }),
              )
            ],
          ),
        ),
      ),
    );
  }
}
