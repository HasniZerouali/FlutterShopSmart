import 'dart:developer';
import 'package:dynamic_height_grid_view/dynamic_height_grid_view.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shopsmart_users/models/product_model.dart';
import 'package:shopsmart_users/providers/product_provider.dart';
import 'package:shopsmart_users/providers/theme_provider.dart';
import 'package:shopsmart_users/services/assets_manager.dart';
import 'package:shopsmart_users/widgets/products/product_widget.dart';
import 'package:shopsmart_users/widgets/title_text.dart';

class SearchScreen extends StatefulWidget {
  const SearchScreen({super.key});

  @override
  State<SearchScreen> createState() => _SearchScreenState();
}

class _SearchScreenState extends State<SearchScreen> {
  late TextEditingController searchTextController;
  @override
  void initState() {
    // TODO: implement initState
    searchTextController = TextEditingController();

    super.initState();
  }

  //dispos tkhawi mohtawa ta3 var ml memori bach matakalch l app
  @override
  void dispose() {
    // TODO: implement dispose
    searchTextController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    // nasta3mil l provider
    final productProvider = Provider.of<ProductProvider>(context);
    return GestureDetector(
      // dirha wla dir InkWell bach bach min tadrak 3la khwa yagla3 keybord ta3 textfield
      onTap: () {
        FocusScope.of(context).unfocus();
      },
      child: Scaffold(
        appBar: AppBar(
          title: const TitlesTextWidget(
            fontSize: 20,
            label: 'Search',
          ),
          leading: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Image.asset(AssetsManager.shoppingCart),
          ),
        ),
        body: Padding(
          padding: const EdgeInsets.all(8.0),
          child: SingleChildScrollView(
            child: Column(
              children: [
                const SizedBox(height: 15),
                TextField(
                  controller: searchTextController,
                  //bach min tadrak 3la khwa yagla3 keybord
                  decoration: InputDecoration(
                    hintText: "Search",
                    prefixIcon: GestureDetector(
                      onTap: () {},
                      child: const Icon(Icons.search),
                    ),
                    suffixIcon: GestureDetector(
                      onTap: () {
                        // setState(() {
                        searchTextController
                            .clear(); //bla mandir setState khartch .clear() roha dir rebuld lal widget
                        FocusScope.of(context).unfocus();
                        // });
                      },
                      child: const Icon(
                        Icons.clear,
                        color: Color(0xffb3271c),
                      ),
                    ),
                  ),
                  onSubmitted: (value) {
                    //kol mayadrk ok fal clavie t3ayat lhad i l fun
                    log(searchTextController.text);
                  },
                  onChanged: (value) {
                    //kol mayaktab haja y3ayat lhadi l fuc
                  },
                ),
                const SizedBox(height: 15),
                Container(
                  child: DynamicHeightGridView(
                    shrinkWrap:
                        true, //dir hado wla dirha fi expanded + column fi SingleChildScrollView
                    physics: const NeverScrollableScrollPhysics(),
                    // itemCount: ProductModel.localProds.length,
                    itemCount: productProvider.getProducts.length,
                    builder: ((context, index) {
                      return ChangeNotifierProvider.value(
                        // hadi tarika lawla bsh haka tatmacha ri fal searchscreen bsh matl3ch fal wishlis w ..
                        //  lazam ykon fal paren lisiner, yatsama3 3la tarayorat (lal productModel)
                        // haka mastakhdamnach constructor

                        value: productProvider.getProducts[index],
                        child: ProductWidget(
                          productId: productProvider.getProducts[index].productId,
                            // image: ProductModel.localProds[index].productImage,
                            // image: productProvider.getProducts[index].productImage,
                            //  tagla3 paramter li fal constructur (hadi hiya faydat provider tasta3amlah bla matmarar l9iyam fal constructor)
                            ),
                      );
                    }),
                    crossAxisCount: 2,
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
