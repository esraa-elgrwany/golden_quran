import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:hive/hive.dart';
import 'package:hive_flutter/adapters.dart';
import 'package:islami_project/hadethdetails.dart';
import 'package:islami_project/homeScreen.dart';
import 'package:islami_project/mythemedata.dart';
import 'package:islami_project/notification/notification.dart';
import 'package:islami_project/pray_times.dart';
import 'package:islami_project/providers/my_provider.dart';
import 'package:islami_project/splash_screen.dart';
import 'package:islami_project/suradetails.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:islami_project/tabs/settingtab.dart';
import 'package:provider/provider.dart';
import 'package:timezone/data/latest.dart' as tz;

void main() async{
  WidgetsFlutterBinding.ensureInitialized();
  tz.initializeTimeZones();
  await NotificationService.init();
  await Hive.initFlutter();
  await Hive.openBox("counterBox");
  await Hive.openBox("tempCounterBox");
  await Hive.openBox('settingsBox');
  runApp(MultiProvider(providers: [
    ChangeNotifierProvider(
      create: (context) => MyProvider(),
    ),
  ], child: const MyApp()));
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    var pro = Provider.of<MyProvider>(context);
    return  ScreenUtilInit(
      designSize: const Size(412, 873),
      minTextAdapt: true,
      splitScreenMode: true,
      builder: (context, child) =>MaterialApp(
        localizationsDelegates: AppLocalizations.localizationsDelegates,
        supportedLocales: AppLocalizations.supportedLocales,
        locale: Locale(pro.languageCode),
        debugShowCheckedModeBanner: false,
        initialRoute: SplashScreen.routeName,
        routes: {
          SplashScreen.routeName:(context) => SplashScreen(),
          HomeScreen.routeName: (context) => HomeScreen(),
          SuraDetails.routeName: (context) => SuraDetails(),
          HadethDetails.routeName: (context) => HadethDetails(),
          SettingTab.routeName:(context) =>SettingTab(),
          PrayTimesScreen.routeName:(context) =>PrayTimesScreen(),
        },
        themeMode: pro.modeApp,
        theme: MyThemeData.lightTheme,
        darkTheme: MyThemeData.darkTheme,
      ),
    );
  }
}
