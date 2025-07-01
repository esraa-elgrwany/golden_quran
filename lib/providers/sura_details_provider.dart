
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:islami_project/tabs/qurantab.dart';

class SuraDetailsProvider extends ChangeNotifier{
  List<String> verses = [];
  List<String> allVerses = [];
  List<int> versesLength=[];
  loadFile(int index) async {
    String file = await rootBundle.loadString("assets/files/${index + 1}.txt");
    List<String> lines = file.trim().split("\n");
    verses = lines;
   notifyListeners();
  }
  loadAllFiles()async{
    for(int i=0;i<QuranTab.suraName.length;i++){
      String allFiles = await rootBundle.loadString("assets/files/${i + 1}.txt");
      List<String> files = allFiles.trim().split("\n");
      allVerses=files;
      versesLength.add(allVerses.length);
      notifyListeners();
    }
  }
}
