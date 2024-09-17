import 'dart:developer';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:ionicons/ionicons.dart';
import 'package:shopsmart_users/root_screen.dart';
import 'package:shopsmart_users/services/my_app_method.dart';

class GoogleButton extends StatelessWidget {
  const GoogleButton({super.key});
  Future<void> _goolgeSignIn({required BuildContext context}) async {
    final googleSignIn = GoogleSignIn();
    final googleAccount = await googleSignIn
        .signIn(); //hadi bach tadi lma3loumat mal google accunt t3 user
    if (googleAccount != null) {
      final googleAuth = await googleAccount.authentication;
      // hadi bach njib authentication ta3 google accunt
      if (googleAuth.accessToken != null && googleAuth.idToken != null) {
        //ida 3andah hado "ta3 token w google Account" ya3ni 3amal login succusful m3a  Gmail ta3h
        try {
          final authResults = await FirebaseAuth.instance.signInWithCredential(
              GoogleAuthProvider.credential(
                  accessToken: googleAuth.accessToken,
                  idToken: googleAuth.idToken)); //haka darna logni m3a Gmail
//collection kichrol hiya tableau fal DB relational , doc hiya id ta3h , set na3tiha jison wla map wtkon hiya les ligne ta3 tableux
          if (authResults.additionalUserInfo!.isNewUser) {
            //ndir if bach nchof ida awal mara ysajal bhad gmail , bach machi kol mara yasna3 tableu fal firebase l hada gmail
            log("message");
            await FirebaseFirestore.instance
                .collection("users")
                .doc(authResults.user!.uid)
                .set({
              'userId': authResults.user!.uid,
              'userName': authResults.user!.displayName,
              'userImage': authResults.user!.photoURL,
              'userEmail': authResults.user!.email,
              'createdAt': Timestamp.now(), //mit date.now()
              'userWish': [],
              'userCart': [],
            });
            //bach mayag3odch kol may roh l profileScreen y3awad ydib data(photo, name,....)
          }

          // if (!context.mounted) {
          //   //min rana fi staelessWidget tama makach mounted kayan fi blasatha "context.mounted" , bsh dir addPstFrameCallback khir hnaya liana context momkin ydir mochkila
          //   //zadna hadi bach gla3na "indar" mal Navigator
          //   // ! If the widget is still mounted (part of the widget tree),(screen mazalha active)
          //   // ! we dispose of the controller to free up resources.
          //   return;
          // }Navigator.pushReplacementNamed(context, RootScreen.routName);
          WidgetsBinding.instance.addPostFrameCallback(
            //dart b "addPostFrameCallback" fi blassat "context.mounted" lianaho momkin context ydir mochkila hna
            (_) async {
              await Navigator.pushReplacementNamed(
                  context, RootScreen.routName);
            },
          );
        } on FirebaseException catch (error) {
          //tzid on FirebaseException.. w tani error.message bach l erro tji makhtasra ta3 firebase
          WidgetsBinding.instance.addPostFrameCallback(
            (_) async {
              await MyAppMethods.showErrorORWarningDialog(
                context: context,
                subtitle: "An error has been occured ${error.message}",
                fct: () {},
              );
            },
          );
        } catch (error) {
          //tzid hadi khatrch yamkan yasra error machi ta3 "FirebaseAuthException"
          WidgetsBinding.instance.addPostFrameCallback(
            (_) async {
              await MyAppMethods.showErrorORWarningDialog(
                context: context,
                subtitle: "An error has been occured $error",
                fct: () {},
              );
            },
          );
        }
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return ElevatedButton.icon(
      style: ElevatedButton.styleFrom(
        padding: const EdgeInsets.all(12),
        // backgroundColor: Colors.white,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(
            10,
          ),
        ),
      ),
      icon: const Icon(
        Ionicons.logo_google,
        color: Colors.red,
      ),
      label: const Text(
        "Sign in with google",
        style: TextStyle(
          fontSize: 16.0,
          // color: Colors.black,
        ),
      ),
      onPressed: () async {
        await _goolgeSignIn(context: context);
      },
    );
  }
}
