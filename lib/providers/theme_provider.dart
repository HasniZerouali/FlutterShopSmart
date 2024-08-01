import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

//changeNotifier bach ta3raf ga3 tarayorat
class ThemeProvider with ChangeNotifier {
  static const THEME_STATUS = "THEME_STATUS";
//key ta3 charedpreference
  bool _darkTheme = false;
  bool get getIsDarkTheme => _darkTheme;

  ThemeProvider() {
    getTheme();
    //min tmachi l app (li hiya radi y3ayat lal constructor yadi l9ima likant mahfoda fal shared preference
  }
  Future<void> setDarkTheme({required bool themeValue}) async {
    //hadi set lal var _darkTheme
    //(future , async),await, ma3natha matmachich stora li thatha hata tkaml hiya(..getInstance)
    SharedPreferences prefs = await SharedPreferences.getInstance();
    // save fal memorie ta3 user
    prefs.setBool(THEME_STATUS, themeValue);
    _darkTheme = themeValue;
    //tarayorat yasro tam tam
    notifyListeners(); //natsama3 3la tarayorat li sraw
  }

  Future<bool> getTheme() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    _darkTheme = prefs.getBool(
          THEME_STATUS,
        ) ??
        false; //?? false ya3ni ida kan THEME_STATUS null dirha false
    notifyListeners();
    //hadi get tjib l9ima ta3 THEME_STATUS(mahfoda fa memeori) wthatha
    // f _darkTheme bach getIsDarkTheme yadi l9ima talya lmahfoda
    return _darkTheme;
  }
}
