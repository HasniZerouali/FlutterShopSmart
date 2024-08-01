import 'package:flutter/material.dart';
import 'package:shopsmart_users/constants/app_colors.dart';

class Styles {
  static ThemeData themeData({
    // lhala liftiradiya lal les color kon matmadalhomche 9ima
    required bool isDarkTheme,
    required BuildContext context,
  }) {
    return ThemeData(
      scaffoldBackgroundColor: isDarkTheme
          ? AppColors.darkScaffoldColor
          : AppColors.lightScaffoldColor,
      cardColor: isDarkTheme
          ? const Color.fromARGB(255, 13, 6, 37)
          : AppColors.lightCardColor,
      brightness: isDarkTheme ? Brightness.dark : Brightness.light,
      //lkhalfiya ta3 buton tji kahla w text bayda
      appBarTheme: AppBarTheme(
          iconTheme:
              IconThemeData(color: isDarkTheme ? Colors.white : Colors.black),
          backgroundColor: isDarkTheme
              ? AppColors.darkScaffoldColor
              : AppColors.lightScaffoldColor,
          elevation: 0,
          centerTitle: false,
          titleTextStyle:
              TextStyle(color: isDarkTheme ? Colors.white : Colors.black)),
      inputDecorationTheme: InputDecorationTheme(
        filled: true, //tlawan lkhalfiya
        contentPadding: const EdgeInsets.all(10),
        enabledBorder: OutlineInputBorder(
          //hadi wli tahta ta3 l border min ykon normal w min ykon mfokes (madrok)
          borderSide: const BorderSide(
            width: 1,
            color: Colors.transparent,
          ),
          borderRadius: BorderRadius.circular(8),
        ),
        focusedBorder: OutlineInputBorder(
          borderSide: BorderSide(
            width: 1,
            color: isDarkTheme ? Colors.white : Colors.black,
          ),
          borderRadius: BorderRadius.circular(8),
        ),
        errorBorder: OutlineInputBorder(
          //hadi wa li ththa fi halat  error kiwali l border mitl fi erro f signIN W LOGIN
          borderSide: BorderSide(
            width: 1,
            color: Theme.of(context).colorScheme.error,
          ),
          borderRadius: BorderRadius.circular(8),
        ),
        focusedErrorBorder: OutlineInputBorder(
          borderSide: BorderSide(
            width: 1,
            color: Theme.of(context).colorScheme.error,
          ),
          borderRadius: BorderRadius.circular(8),
        ),
      ),
    );
  }
}
