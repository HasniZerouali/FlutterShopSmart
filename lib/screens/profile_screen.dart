import 'package:flutter/material.dart';
import 'package:iconly/iconly.dart';
import 'package:provider/provider.dart';
import 'package:shopsmart_users/providers/theme_provider.dart';
import 'package:shopsmart_users/root_screen.dart';
import 'package:shopsmart_users/screens/auth/login.dart';
import 'package:shopsmart_users/screens/inner_screens/viewed_recently.dart';
import 'package:shopsmart_users/screens/inner_screens/wishlist.dart';
import 'package:shopsmart_users/services/assets_manager.dart';
import 'package:shopsmart_users/services/my_app_method.dart';
import 'package:shopsmart_users/widgets/app_name_text.dart';
import 'package:shopsmart_users/widgets/subtitle_text.dart';
import 'package:shopsmart_users/widgets/title_text.dart';

class ProfileScreen extends StatelessWidget {
  const ProfileScreen({super.key});

  @override
  Widget build(BuildContext context) {
    // nasta3mil l provider
    // (context, listen: true) listen min dereh true ywali provider yatsama3
    final themeProvider = Provider.of<ThemeProvider>(context);
    return Scaffold(
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
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Visibility(
              //id kan false takhtafi had widget
              visible: false,
              child: Padding(
                padding: EdgeInsets.all(20.0),
                child: TitlesTextWidget(
                    label: "please login to have ultimate access"),
              ),
            ),
            const SizedBox(height: 20),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 10),
              child: Row(
                children: [
                  Container(
                    height: 60,
                    width: 60,
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      color: Theme.of(context).cardColor,
                      border: Border.all(
                        color: Theme.of(context).colorScheme.surface,
                        width: 3,
                      ),
                      image: const DecorationImage(
                        image: NetworkImage(
                            "https://iconape.com/wp-content/files/nb/368023/png/368023.png"),
                        fit: BoxFit.fill,
                      ),
                    ),
                  ),
                  const SizedBox(
                    width: 7,
                  ),
                  const Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      TitlesTextWidget(label: "Hasni Zerouali"),
                      SubtitleTextWidget(label: "hasnizerouali@gmail.com"),
                    ],
                  ),
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 24),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const TitlesTextWidget(label: "General"),
                  CustomListTile(
                    imagePath: AssetsManager.orderSvg,
                    function: () {},
                    text: "All orders",
                  ),
                  CustomListTile(
                    imagePath: AssetsManager.wishlistSvg,
                    function: () async {
                      await Navigator.pushNamed(
                          context, WishlistScreen.routName);
                    },
                    text: "Wishlist",
                  ),
                  CustomListTile(
                    imagePath: AssetsManager.recent,
                    function: () async {
                      await Navigator.pushNamed(
                          context, ViewedRecentlyScreen.routName);
                    },
                    text: "Viewed recently",
                  ),
                  CustomListTile(
                    imagePath: AssetsManager.address,
                    function: () {},
                    text: "Address",
                  ),
                  const Divider(
                    thickness: 1,
                  ),
                  const SizedBox(height: 7),
                  const TitlesTextWidget(label: "Settings"),
                  const SizedBox(height: 7),
                  SwitchListTile(
                    secondary: Image.asset(
                      AssetsManager.theme,
                      height: 30,
                    ),
                    title: Text(
                      themeProvider.getIsDarkTheme
                          ? "Dark Theme"
                          : "Light Theme",
                    ),
                    value: themeProvider.getIsDarkTheme,
                    onChanged: (value) {
                      themeProvider.setDarkTheme(themeValue: value);
                    },
                  ),
                  const Divider(
                    thickness: 1,
                  ),
                ],
              ),
            ),
            Center(
              child: ElevatedButton.icon(
                style: ElevatedButton.styleFrom(
                    iconColor: Colors.white,
                    backgroundColor: Colors.red,
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(30))),
                label: const Text(
                  "Login",
                  style: TextStyle(color: Colors.white),
                ),
                icon: const Icon(Icons.login),
                onPressed: () async {
                  await MyAppMethods.showErrorORWarningDialog(
                    context: context,
                    subtitle: "Are you sur",
                    isError: false,
                    fct: () {
                      // Navigator.pop(context);
                      // Navigator.pushNamed(context, LoginScreen.routName);
                      Navigator.pushNamed(context, LoginScreen.routName);
                    },
                  );
                },
              ),
            )
          ],
        ),
      ),
    );
  }
}

class CustomListTile extends StatelessWidget {
  const CustomListTile({
    super.key,
    required this.imagePath,
    required this.text,
    required this.function,
  });

  final String imagePath, text;
  final Function function;

  @override
  Widget build(BuildContext context) {
    return ListTile(
      onTap: () {
        function();
      },
      leading: Image.asset(
        imagePath,
        height: 30,
      ),
      title: SubtitleTextWidget(
        label: text,
      ),
      trailing: const Icon(IconlyLight.arrow_right_2),
    );
  }
}
