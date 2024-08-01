import 'package:flutter/material.dart';
import 'package:iconly/iconly.dart';
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

  @override
  Widget build(BuildContext context) {
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
        destinations: const [
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
              label: Text("6"),
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
