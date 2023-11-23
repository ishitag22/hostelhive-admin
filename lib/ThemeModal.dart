import 'package:hostelhive_admin/theme.dart';
import 'package:flutter/cupertino.dart';

class ThemeModal extends ChangeNotifier{
  static late bool _isDark;
  late Theme themeSharedPreferences;
  bool get isDark => _isDark;

  ThemeModal(){
    _isDark= false;
    themeSharedPreferences= Theme();
  }

  set isDark(bool value){
    _isDark=value;
    themeSharedPreferences.setTheme(value);
    notifyListeners();
  }
  getThemePreferences() async{
    _isDark= await themeSharedPreferences.getTheme();
    notifyListeners();
  }
}

