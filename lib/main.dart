import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:shopsmart_users/constants/theme_data.dart';
import 'package:shopsmart_users/providers/cart_provider.dart';
import 'package:shopsmart_users/providers/product_provider.dart';
import 'package:shopsmart_users/providers/theme_provider.dart';
import 'package:shopsmart_users/providers/viewed_prod_provider.dart';
import 'package:shopsmart_users/providers/wishlist_provider.dart';
import 'package:shopsmart_users/root_screen.dart';
import 'package:provider/provider.dart';
import 'package:shopsmart_users/screens/auth/forgot_password.dart';
import 'package:shopsmart_users/screens/auth/login.dart';
import 'package:shopsmart_users/screens/auth/register.dart';
import 'package:shopsmart_users/screens/home_screen.dart';
import 'package:shopsmart_users/screens/inner_screens/orders/orders_screen.dart';
import 'package:shopsmart_users/screens/inner_screens/product_details.dart';
import 'package:shopsmart_users/screens/inner_screens/viewed_recently.dart';
import 'package:shopsmart_users/screens/inner_screens/wishlist.dart';
import 'package:shopsmart_users/screens/search_screen.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    // final themeProvider=Provider.of<ThemeProvider>(context);
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: FutureBuilder(
        future: Firebase.initializeApp(), //initiali l firebase lga3 l app
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            //hadi lawla fi halat waiting rah 3ad ydir initialisation la firebase
            return Scaffold(
                body: Center(
              child: CircularProgressIndicator(
                color: Colors.deepPurple,
                backgroundColor: Colors.grey[300],
                strokeWidth: 6.0,
                // Set the animation for the progress indicator's color
                valueColor: AlwaysStoppedAnimation<Color>(Colors.deepPurple),
                semanticsLabel: 'Loading...',
                strokeCap: StrokeCap.round,
              ),
            ));
          } else if (snapshot.hasError) {
            //whadi ida sra error atnaa initialisation ta3 firebase
            return Scaffold(
              body: Center(
                child: SelectableText(
                    "An error has been occured ${snapshot.error}"),
              ),
            );
          }
          //w ida masra hata error fal initaialisation ta3 firebase t return app ta3na nrml
          return MultiProvider(
            //tarayor(provider) yasra 3la ga3 l app tama ntabkoh 3la(a3la parent how :) MaterialApp
            providers: [
              ChangeNotifierProvider(
                create: (_) {
                  return ThemeProvider();
                },
              ), //haka sayi nwalo najmo natsam3o 3la provider
              ChangeNotifierProvider(
                create: (_) {
                  return ProductProvider();
                },
              ), //haka sayi nwalo najmo natsam3o 3la provider
              ChangeNotifierProvider(
                create: (_) {
                  return CartProvider();
                },
              ),
              ChangeNotifierProvider(
                create: (_) {
                  return WishlistProvider();
                },
              ),
              ChangeNotifierProvider(
                create: (_) {
                  return ViewedProdProvider();
                },
              ),
            ],

            //Consumer min tkon widget wahda tatsama3 ela tarayoro=)
            // bach n3araf var (themeProvider)li fig theme t or f ta3 li jabnaha ml SwitchListTile
            //kona najmo fiblassat consumer n3awdo ndiclaro l var   :  final themeProvider = Provider.of<ThemeProvider>(context);

            child: Consumer<ThemeProvider>(
              builder: (context, themeProvider, child) {
                return MaterialApp(
                  title: "Shop Smart AR",
                  theme: Styles.themeData(
                      isDarkTheme: themeProvider.getIsDarkTheme,
                      context: context),
                  debugShowCheckedModeBanner: false,
                  home: LoginScreen(),
                  // home: const RootScreen(),
                  routes: {
                    // tnajam tktb '/ProductDetails': ... fiblasat ....routName
                    ProductDetails.routName: (context) =>
                        const ProductDetails(),
                    "/login": (context) => const LoginScreen(),
                    WishlistScreen.routName: (context) =>
                        const WishlistScreen(),
                    LoginScreen.routName: (context) => const LoginScreen(),
                    SearchScreen.routeName: (context) => const SearchScreen(),
                    RootScreen.routName: (context) => const RootScreen(),
                    OrdersScreenFree.routeName: (context) =>
                        const OrdersScreenFree(),
                    ForgotPasswordScreen.routeName: (context) =>
                        const ForgotPasswordScreen(),
                    RegisterScreen.routName: (context) =>
                        const RegisterScreen(),
                    ViewedRecentlyScreen.routName: (context) =>
                        const ViewedRecentlyScreen(),
                  },
                );
              },
            ),
          );
        },
      ),
    );
  }
}
