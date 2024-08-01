import 'dart:developer';
import 'package:dynamic_height_grid_view/dynamic_height_grid_view.dart';
import 'package:flutter/material.dart';
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
                    itemCount: 20,
                    builder: ((context, index) {
                      return const ProductWidget();
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
