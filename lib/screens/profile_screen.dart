import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:iconly/iconly.dart';
import 'package:provider/provider.dart';
import 'package:shopsmart_users/models/user_model.dart';
import 'package:shopsmart_users/providers/theme_provider.dart';
import 'package:shopsmart_users/providers/user_provider.dart';
import 'package:shopsmart_users/root_screen.dart';
import 'package:shopsmart_users/screens/auth/login.dart';
import 'package:shopsmart_users/screens/inner_screens/orders/orders_screen.dart';
import 'package:shopsmart_users/screens/inner_screens/viewed_recently.dart';
import 'package:shopsmart_users/screens/inner_screens/wishlist.dart';
import 'package:shopsmart_users/screens/loading_manager.dart';
import 'package:shopsmart_users/services/assets_manager.dart';
import 'package:shopsmart_users/services/my_app_method.dart';
import 'package:shopsmart_users/widgets/app_name_text.dart';
import 'package:shopsmart_users/widgets/subtitle_text.dart';
import 'package:shopsmart_users/widgets/title_text.dart';

class ProfileScreen extends StatefulWidget {
  const ProfileScreen({super.key});

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen>
    with AutomaticKeepAliveClientMixin {
  bool get wantKeepAlive =>
      true; //hadi hiya wal Aut..Micisn tkhali state ta3 had screen dima active (alive) ,ma3natha machi kol matroh la screen wakhdokhra watwali lhadi y3awad ytala3 data(m3natah may3awadch y3ayat l initState()) , ri screen li tasha9 yogo3do active dalhom haka machi ga3 traja3hom active bach mata9alch l app
  User? user = FirebaseAuth
      .instance.currentUser; //hada ida can null ya3ni user machi dayar login

  bool _isLoading = true;
  UserModel? userModel;

  Future<void> fetchUserInfo() async {
    if (user == null) {
      setState(() {
        _isLoading = false;
      });
      return;
    }
    final userProvider = Provider.of<UserProvider>(context, listen: false);
    try {
      userModel = await userProvider.fetchUserInfo();
    } catch (error) {
      //tzid hadi khatrch yamkan yasra error machi ta3 "FirebaseAuthException"
      MyAppMethods.showErrorORWarningDialog(
        context: context,
        subtitle: "An error has been occured $error",
        fct: () {},
      );
    } finally //"finally" y3ayatalha min ykamal try wla error
    {
      setState(() {
        _isLoading = false;
      });
    }
  }

  @override
  void initState() {
    fetchUserInfo();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    super.build(context); //zid hadi tani bahc twali screen active
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
      body: LoadingManager(
        isLoading: _isLoading,
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Visibility(
                //id kan false takhtafi had widget
                visible: user == null ? true : false,
                child: Padding(
                  padding: EdgeInsets.all(20.0),
                  child: TitlesTextWidget(
                      label: "please login to have ultimate access"),
                ),
              ),
              const SizedBox(height: 20),
              userModel == null
                  ? SizedBox.shrink()
                  : Padding(
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
                              image: DecorationImage(
                                image: NetworkImage(
                                  userModel!.userImage,
                                ),
                                fit: BoxFit.fill,
                              ),
                            ),
                          ),
                          const SizedBox(
                            width: 7,
                          ),
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              TitlesTextWidget(label: userModel!.userName),
                              SubtitleTextWidget(label: userModel!.userEmail),
                            ],
                          ),
                        ],
                      ),
                    ),
              Padding(
                padding:
                    const EdgeInsets.symmetric(horizontal: 12, vertical: 24),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const TitlesTextWidget(label: "General"),
                    user == null
                        ? const SizedBox.shrink()
                        : CustomListTile(
                            imagePath: AssetsManager.orderSvg,
                            function: () async {
                              await Navigator.pushNamed(
                                  context, OrdersScreenFree.routeName);
                            },
                            text: "All orders",
                          ),
                    user == null
                        ? const SizedBox.shrink()
                        : CustomListTile(
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
                        print("user is ${user} user");
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
                  label: Text(
                    user == null ? "Login" : "Logout",
                    style: TextStyle(color: Colors.white),
                  ),
                  icon: Icon(user == null ? Icons.login : Icons.logout),
                  onPressed: () async {
                    if (user == null) {
                      await Navigator.pushReplacementNamed(
                          context, LoginScreen.routName);
                    } else {
                      await MyAppMethods.showErrorORWarningDialog(
                        context: context,
                        subtitle: "Are you sur",
                        isError: false,
                        fct: () async {
                          await FirebaseAuth.instance.signOut();
                          if (!mounted)
                            return; //hadi tzidha 3la jal tahdir li fal Navigator , tnajam dir fi blasatha "addPostFrameCallback" mofida lal await
                          await Navigator.pushReplacementNamed(
                              context, LoginScreen.routName);
                        },
                      );
                    }
                  },
                ),
              )
            ],
          ),
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
