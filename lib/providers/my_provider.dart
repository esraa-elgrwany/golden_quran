import 'package:flutter/material.dart';

class MyProvider extends ChangeNotifier{
  String languageCode="en";
   ThemeMode modeApp=ThemeMode.light;

  changeLanguage(String langCode){
    languageCode=langCode;
    notifyListeners();
  }

  changeMode(ThemeMode mode){
    modeApp=mode;
    notifyListeners();
  }
  String getBackground(){
    if(modeApp==ThemeMode.light){
      return "assets/images/background.png";
    }else{
      return "assets/images/dark_bg.png";
    }
  }
}