import 'package:flutter/material.dart';
import 'package:islami_project/providers/my_provider.dart';
import 'package:islami_project/tabs/ahadethtab.dart';
import 'package:islami_project/tabs/list_tab.dart';
import 'package:islami_project/tabs/qurantab.dart';
import 'package:islami_project/tabs/radiotab.dart';
import 'package:islami_project/tabs/sebha.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:islami_project/tabs/settingtab.dart';
import 'package:provider/provider.dart';

class HomeScreen extends StatefulWidget{

  static const String routeName="home";

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  int index=0;

  @override
  Widget build(BuildContext context) {
    var pro=Provider.of<MyProvider>(context);
    return Stack(
      children: [
      Image.asset(pro.getBackground(),width: double.infinity,fit: BoxFit.cover,),
        Scaffold(
         appBar: AppBar(
           surfaceTintColor: Colors.transparent,
           elevation: 0,
            forceMaterialTransparency: true
           ,
           title: Text(AppLocalizations.of(context)!.appTitle
               ,style: Theme.of(context).textTheme.bodyLarge
         ),
           leading:Container(
             margin: EdgeInsets.only(right:4,left: 4),
             child: IconButton(onPressed: () {
               Navigator.push(context,MaterialPageRoute(builder:
                   (context) => SettingTab(),));
             }, icon:Icon(Icons.settings_suggest_outlined,size: 40, color: Theme
                 .of(context)
                 .colorScheme
                 .onBackground)),
           ), 
        ),
          bottomNavigationBar: BottomNavigationBar(
            onTap: (value) {
              index=value;
              setState(() {
              });
            },

            currentIndex: index,
            items: [
              BottomNavigationBarItem(icon:ImageIcon(AssetImage("assets/images/quran.png")),
                label: AppLocalizations.of(context)!.quran,
                backgroundColor: Theme.of(context).colorScheme.primary,),
              BottomNavigationBarItem(icon:ImageIcon(AssetImage("assets/images/ahadeth.png")),
                label: AppLocalizations.of(context)!.ahadeth,
                backgroundColor: Theme.of(context).colorScheme.primary, ),
              BottomNavigationBarItem(icon:ImageIcon(AssetImage("assets/images/sebha.png")),
                label:AppLocalizations.of(context)!.sebha,
                backgroundColor: Theme.of(context).colorScheme.primary,),
            BottomNavigationBarItem(icon:ImageIcon(AssetImage("assets/images/radio.png")),
                label:AppLocalizations.of(context)!.radio ,
              backgroundColor: Theme.of(context).colorScheme.primary, ),
            BottomNavigationBarItem(icon: Icon(Icons.list),label: AppLocalizations.of(context)!.list,
              backgroundColor: Theme.of(context).colorScheme.primary,),
          ],
          ),
          body: tabs[index],
    ),
      ],
    );
  }
  List<Widget>tabs=[QuranTab(),AhadethTab(),SebhaTab(),RadioTab(),ListTab()];
}
