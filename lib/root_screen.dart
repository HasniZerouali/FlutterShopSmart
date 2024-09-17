import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:iconly/iconly.dart';
import 'package:provider/provider.dart';
import 'package:shopsmart_users/providers/cart_provider.dart';
import 'package:shopsmart_users/providers/product_provider.dart';
import 'package:shopsmart_users/providers/wishlist_provider.dart';
import 'package:shopsmart_users/screens/cart/cart_screen.dart';
import 'package:shopsmart_users/screens/home_screen.dart';
import 'package:shopsmart_users/screens/profile_screen.dart';
import 'package:shopsmart_users/screens/search_screen.dart';

//screen by default
class RootScreen extends StatefulWidget {
  static const routName = '/RootScreen';

  const RootScreen({super.key});

  @override
  State<RootScreen> createState() => _RootScreenState();
}

class _RootScreenState extends State<RootScreen> {
  late PageController controller;
  //late ma3natha var radi yadi 9ima mn ba3d basur
  //kima fi hadi lhala  madinalah f initState()
  int currentScreen = 0;
  bool _isLoadingProds = true;
  List<Widget> screens = [
    const HomeScreen(),
    const SearchScreen(),
    const CartScreen(),
    const ProfileScreen(),
  ];
  @override
  void initState() {
    super.initState();
    controller = PageController(initialPage: currentScreen);
    // rakalm page m selectionya
  } //function t3ayatalha awal matfot 3la had creen

  Future<void> fetchFCT() async {
    final productProvider =
        Provider.of<ProductProvider>(context, listen: false);
    final cartProvider = Provider.of<CartProvider>(context, listen: false);
    final wishlistProvider =
        Provider.of<WishlistProvider>(context, listen: false);
    try {
      Future.wait(
        {productProvider.fetchProducts()},
      );
      //futrue.wait lmlih fiha tnjm dir dkhal fiha ch3l mn whda wt9ara3lhom ga3 mchi balwahd  , hadi mliha bach tsara3lk l application
      //  cart tasha9 9blha product  lihada ndiroha moraha min tkml , tbda ta3 cart
      Future.wait({
        cartProvider.fetchCart(),
        wishlistProvider.fetchWishlist(),//ndiro wich hnaya khtrch ta3tamad 3la productProvider tama hata ykamal tbda hadi
      });
    } catch (error) {
      log(error.toString());
    } finally {
      _isLoadingProds = false;
    }
  }

  @override
  void didChangeDependencies() {
    //dartha hna w machi fi initState() khatrch hadi "didChangeDependencies" yat3ayatalha fal badya wtani kol mayasra tarayor
    // TODO: implement didChangeDependencies
    if (_isLoadingProds) {
      //dartha f had if bach fct y3ayatalha ri khatra whda
      fetchFCT();
    }

    super.didChangeDependencies();
  }

  @override
  Widget build(BuildContext context) {
    final cartProvider = Provider.of<CartProvider>(context);

    return Scaffold(
      body: PageView(
        controller: controller,
        physics: const NeverScrollableScrollPhysics(),
        children: screens, //bach thabas swip mabin li page
        //dir les page li yakhorjolak w takhtar matahta
      ),
      bottomNavigationBar: NavigationBar(
        selectedIndex: currentScreen, //hada bach twarilah icon selected
        backgroundColor: Theme.of(context).scaffoldBackgroundColor,
        //hada bach twarilah nafs color background ta3 scaffold
        elevation: 2,
        height: kBottomNavigationBarHeight, //irtifa3 l bar
        onDestinationSelected: (index) {
          setState(
            () {
              currentScreen = index;
            },
          );

          controller.jumpToPage(currentScreen);
        },
        destinations: [
          NavigationDestination(
            selectedIcon: Icon(
              IconlyBold.home,
            ), //icon mosta3mala 3indama takon hiya mseelectionya
            icon: Icon(IconlyLight.home),
            label: "Home",
          ),
          NavigationDestination(
            selectedIcon: Icon(
              IconlyBold.search,
            ),
            icon: Icon(IconlyLight.search),
            label: "Search",
          ),
          NavigationDestination(
            selectedIcon: Icon(
              IconlyBold.bag_2,
            ),
            icon: Badge(
              label: Text("${cartProvider.getCartItems.length}"),
              child: Icon(IconlyLight.bag_2),
            ),
            label: "Cart",
          ),
          NavigationDestination(
            selectedIcon: Icon(
              IconlyBold.profile,
            ),
            icon: Icon(IconlyLight.profile),
            label: "Profile",
          ),
        ],
      ),
    );
  }
}
