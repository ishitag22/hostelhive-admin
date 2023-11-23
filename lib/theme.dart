import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class Theme{
  static const PREF_KEY = "Preferences";

  setTheme(bool value) async{
    SharedPreferences sharedPreferences= await SharedPreferences.getInstance();
    sharedPreferences.setBool(PREF_KEY, value);
  }
  getTheme() async{
    SharedPreferences sharedPreferences= await SharedPreferences.getInstance();
    return sharedPreferences.get(PREF_KEY) ?? false;
  }
}