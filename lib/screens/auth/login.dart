import 'dart:developer';
import 'dart:ffi';

import 'package:flutter/material.dart';
import 'package:iconly/iconly.dart';
import 'package:shopsmart_users/constants/app_colors.dart';
import 'package:shopsmart_users/constants/my_validators.dart';
import 'package:shopsmart_users/root_screen.dart';
import 'package:shopsmart_users/screens/auth/register.dart';
import 'package:shopsmart_users/screens/home_screen.dart';
import 'package:shopsmart_users/services/my_app_method.dart';
import 'package:shopsmart_users/widgets/app_name_text.dart';
import 'package:shopsmart_users/widgets/auth/google_btn.dart';
import 'package:shopsmart_users/widgets/subtitle_text.dart';
import 'package:shopsmart_users/widgets/title_text.dart';

class LoginScreen extends StatefulWidget {
  static const routName = '/LoginScreen';

  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  late final TextEditingController _emailController;
  late final TextEditingController _passwordController;
  late final FocusNode _emailFocusNode;
  late final FocusNode _passwordFocusNode;
  // FocusNode bach min tadrak 3la entrei fal clavi ta3 email thawdak lal  texfield t3 password wtwali fiha icon ta3 sah
  bool obscureText = true;
  late final _formKey = GlobalKey<FormState>();
  //bach nakhadmo bal Form
  @override
  void initState() {
    // TODO: implement initState
    _emailController = TextEditingController();
    _passwordController = TextEditingController();
    // Focus Nodes
    _emailFocusNode = FocusNode();
    _passwordFocusNode = FocusNode();
    super.initState();
  }

  //dispos tkhawi mohtawa ta3 var ml memori bach matakalch l app
  @override
  void dispose() {
    // TODO: implement dispose
    _emailController.dispose();
    _passwordController.dispose();
    _emailFocusNode.dispose();
    _passwordFocusNode.dispose();
    super.dispose();
  }

  Future<void> _loginFct() async {
    //hadi hiya lita3mil submit
    final isValid = _formKey.currentState!
        .validate(); //hadi hiya li tchof ida form kompli ga3 textFormField li fih rahom valide (mha9a9 chorot ta3 li darthom fal  "validator: (value)" matalan email)
    FocusScope.of(context).unfocus(); //bach min tadrak submit dir unfocos
    if (isValid
        //  && _emailController.toString().contains("hasni@gmail.com")
        ) {
      setState(() {
        Navigator.pushNamed(context, RootScreen.routName);
      });
      log("hasni vlaid");
    }
  }

//ndiro form and textFormField machi TextField bach najmo nkharjo tahtha error  hamra
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        FocusScope.of(context).unfocus(); //ta3mal unfocus
      },
      child: Scaffold(
        body: Padding(
          padding: const EdgeInsets.all(12.0),
          child: SingleChildScrollView(
            child: Column(
              children: [
                const SizedBox(height: 55),
                AppNameTextWidget(
                  fontSize: 30,
                ),
                const SizedBox(height: 28),
                Align(
                  // wigdet dirha min tabri tharak child
                  alignment: Alignment.centerLeft,
                  child: const TitlesTextWidget(label: "Welcome back"),
                ),
                Align(
                  alignment: Alignment.centerLeft,
                  child: SubtitleTextWidget(
                    label:
                        "Let's get you logged in so you can start exploring.",
                    fontSize: 16,
                  ),
                ),
                const SizedBox(height: 30),
                Form(
                  //dir form bach tnjm t3ayat lal TextFormFiel
                  key: _formKey, //hada key ta3 hada lform
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      TextFormField(
                        controller: _emailController,
                        focusNode: _emailFocusNode,
                        textInputAction: TextInputAction
                            .next, //icon li thi fi blasak ok ta3 clavie
                        keyboardType: TextInputType.emailAddress,
                        decoration: const InputDecoration(
                          hintText: "Email address",
                          prefixIcon: Icon(IconlyLight.message),
                        ),
                        validator: (value) {
                          //fun ta3mal valitadt ri noodorko 3la submit "fihadi hala btn ta3 login"
                          return MyValidators.emailValidator(value);

                          //value fih 9imat li f textformfield
                          // if (value == null || value.isEmpty) {
                          //   return "Cant be empty";
                          // }
                          //function ta3mal valitat lal Form ba3d matadrok 3la submit
                        },
                        onFieldSubmitted: (value) {
                          //bach troh man TextFormField la zawaj litahtah
                          FocusScope.of(context).requestFocus(
                              _passwordFocusNode); //focus li truhlah
                        },
                      ),
                      const SizedBox(height: 16),
                      TextFormField(
                        controller: _passwordController,
                        focusNode: _passwordFocusNode,
                        textInputAction: TextInputAction.done,
                        keyboardType: TextInputType.visiblePassword,
                        obscureText: obscureText,
                        decoration: InputDecoration(
                          hintText: "*********",
                          prefixIcon: const Icon(
                            IconlyLight.lock,
                          ),
                          suffixIcon: IconButton(
                            onPressed: () {
                              setState(() {
                                obscureText = !obscureText;
                              });
                            },
                            icon: Icon(
                              obscureText
                                  ? Icons.visibility
                                  : Icons.visibility_off,
                            ),
                          ),
                        ),
                        validator: (value) {
                          return MyValidators.passwordValidator(value);
                        },
                        onFieldSubmitted: (value) {
                          _loginFct();
                        },
                      ),
                      const SizedBox(height: 16),
                      Align(
                        alignment: Alignment.centerRight,
                        child: TextButton(
                          onPressed: () {
                            Navigator.pushNamed(context, RootScreen.routName);
                          },
                          child: SubtitleTextWidget(
                            label: "Forgot password",
                            textDecoration: TextDecoration.underline,
                            fontWeight: FontWeight.w500,
                            fontStyle: FontStyle.italic,
                          ),
                        ),
                      ),
                      const SizedBox(height: 16),
                      SizedBox(
                        width: double.infinity,
                        child: ElevatedButton.icon(
                          style: ElevatedButton.styleFrom(
                            padding: const EdgeInsets.all(12),
                            // backgroundColor: Colors.red,
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(
                                10,
                              ),
                            ),
                          ),
                          icon: const Icon(Icons.login),
                          label: const Text(
                            "Login",
                            style: TextStyle(
                              fontSize: 20,
                            ),
                          ),
                          onPressed: () async {
                            _loginFct();
                          },
                        ),
                      ),
                      const SizedBox(height: 30),
                      SubtitleTextWidget(
                        label: "OR connect using".toUpperCase(),
                        // color: Colors.transparent.withAlpha(70),
                        color: Theme.of(context).disabledColor,
                        fontWeight: FontWeight.w500,
                      ),
                      const SizedBox(height: 12),
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: SizedBox(
                          height: kBottomNavigationBarHeight + 10,
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceAround,
                            children: [
                              const Expanded(
                                flex: 2,
                                child: SizedBox(
                                  height: kBottomNavigationBarHeight,
                                  child: FittedBox(
                                    child: GoogleButton(),
                                  ),
                                ),
                              ),
                              const SizedBox(
                                width: 8,
                              ),
                              Expanded(
                                child: SizedBox(
                                  height: kBottomNavigationBarHeight,
                                  child: ElevatedButton(
                                    style: ElevatedButton.styleFrom(
                                      padding: const EdgeInsets.all(12),
                                      // backgroundColor:
                                      // Theme.of(context).colorScheme.background,
                                      shape: RoundedRectangleBorder(
                                        borderRadius: BorderRadius.circular(
                                          10,
                                        ),
                                      ),
                                    ),
                                    child: const Text(
                                      "Guest",
                                      style: TextStyle(
                                        fontSize: 20,
                                      ),
                                    ),
                                    onPressed: () async {
                                      _loginFct();
                                    },
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                      const SizedBox(height: 16),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          const SubtitleTextWidget(
                              label: "Don't have an account? "),
                          TextButton(
                            onPressed: () {
                              Navigator.pushNamed(
                                  context, RegisterScreen.routName);
                            },
                            child: SubtitleTextWidget(
                              label: "Sign up",
                              fontWeight: FontWeight.w500,
                              textDecoration: TextDecoration.underline,
                              fontStyle: FontStyle.italic,
                            ),
                          ),
                        ],
                      ),
                    ],
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
