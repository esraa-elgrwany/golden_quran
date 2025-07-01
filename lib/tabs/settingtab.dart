import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:islami_project/mythemedata.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:islami_project/providers/my_provider.dart';
import 'package:provider/provider.dart';

class SettingTab extends StatefulWidget {
  static const String routeName = "settingTab";

  const SettingTab({super.key});

  @override
  State<SettingTab> createState() => _SettingTabState();
}

class _SettingTabState extends State<SettingTab> {
  @override
  Widget build(BuildContext context) {
    var pro = Provider.of<MyProvider>(context);
    return Stack(children: [
      Image.asset(
        pro.getBackground(),
        width: double.infinity,
        fit: BoxFit.cover,
      ),
      Scaffold(
          appBar: AppBar(
            title: Text(AppLocalizations.of(context)!.appTitle,
                style: Theme.of(context).textTheme.bodyLarge),
          ),
          body: Center(
            child: Container(
              margin: EdgeInsets.only(top: 40),
              height: MediaQuery.of(context).size.height * .7,
              child: Center(
                child: Padding(
                  padding: const EdgeInsets.all(32),
                  child: Card(
                    color: pro.modeApp == ThemeMode.light
                        ? Colors.white
                        : MyThemeData.darkPrimary,
                    elevation: 10,
                    shape: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(24),
                        borderSide: BorderSide(
                          color: pro.modeApp == ThemeMode.light
                              ? Colors.white
                              : MyThemeData.darkPrimary,
                        )),
                    child: Padding(
                      padding: const EdgeInsets.all(40),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Row(
                            children: [
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(AppLocalizations.of(context)!.eng,
                                      style: Theme.of(context)
                                          .textTheme
                                          .bodyLarge!
                                          .copyWith(
                                              color: Theme.of(context)
                                                  .colorScheme
                                                  .secondary)),
                                  SizedBox(
                                    height: 6.h,
                                  ),
                                  Text(
                                    AppLocalizations.of(context)!.lang,
                                    style: Theme.of(context)
                                        .textTheme
                                        .bodyMedium!
                                        .copyWith(
                                            color: Theme.of(context)
                                                .colorScheme
                                                .background,
                                            fontSize: 16.sp),
                                  ),
                                  SizedBox(
                                    height: 6.h,
                                  ),
                                ],
                              ),
                              Spacer(),
                              Icon(
                                Icons.language,
                                color: Theme.of(context).colorScheme.surface,
                                size: 30,
                              )
                            ],
                          ),
                          Divider(
                            endIndent: 20,
                            indent: 20,
                            color: Theme.of(context).colorScheme.primary,
                            thickness: 2,
                          ),
                          Row(
                            children: [
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(AppLocalizations.of(context)!.translate,
                                      style: Theme.of(context)
                                          .textTheme
                                          .bodyLarge!
                                          .copyWith(
                                              color: Theme.of(context)
                                                  .colorScheme
                                                  .secondary)),
                                  SizedBox(
                                    height: 6.h,
                                  ),
                                  Text(
                                    AppLocalizations.of(context)!.arabic,
                                    style: Theme.of(context)
                                        .textTheme
                                        .bodyMedium!
                                        .copyWith(
                                            color: Theme.of(context)
                                                .colorScheme
                                                .background,
                                            fontSize: 16.sp),
                                  ),
                                  SizedBox(
                                    height: 6.h,
                                  ),
                                ],
                              ),
                              Spacer(),
                              Switch(
                                activeColor:Theme.of(context).colorScheme.primary,
                                activeTrackColor:pro.isDark? Colors.grey[200]:Colors.grey[300],
                                inactiveTrackColor:pro.isDark? Colors.grey:Colors.white,
                                inactiveThumbColor:pro.isDark?Colors.white:Colors.black ,
                                value: pro.isArabic,
                                onChanged: (value) {
                                  pro.isArabic = value;
                                  if (pro.isArabic == true) {
                                    pro.changeLanguage("ar");
                                  } else {
                                    pro.changeLanguage("en");
                                  }
                                },
                              ),
                            ],
                          ),
                          Divider(
                            endIndent: 20,
                            indent: 20,
                            color: Theme.of(context).colorScheme.primary,
                            thickness: 2,
                          ),
                          Row(
                            children: [
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(AppLocalizations.of(context)!.light,
                                      style: Theme.of(context)
                                          .textTheme
                                          .bodyLarge!
                                          .copyWith(
                                              color: Theme.of(context)
                                                  .colorScheme
                                                  .secondary)),
                                  SizedBox(
                                    height: 6.h,
                                  ),
                                  Text(
                                    AppLocalizations.of(context)!.theme,
                                    style: Theme.of(context)
                                        .textTheme
                                        .bodyMedium!
                                        .copyWith(
                                            color: Theme.of(context)
                                                .colorScheme
                                                .background,
                                            fontSize: 16.sp),
                                  ),
                                  SizedBox(
                                    height: 6.h,
                                  ),
                                ],
                              ),
                              Spacer(),
                              Icon(
                                Icons.sunny,
                                color: Theme.of(context).colorScheme.secondary,
                                size: 30,
                              )
                            ],
                          ),
                          Divider(
                            endIndent: 20,
                            indent: 20,
                            color: Theme.of(context).colorScheme.primary,
                            thickness: 2,
                          ),
                          Row(
                            children: [
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(AppLocalizations.of(context)!.dark,
                                      style: Theme.of(context)
                                          .textTheme
                                          .bodyLarge!
                                          .copyWith(
                                              color: Theme.of(context)
                                                  .colorScheme
                                                  .secondary)),
                                  SizedBox(
                                    height: 6.h,
                                  ),
                                ],
                              ),
                              Spacer(),
                              Switch(
                                activeColor:Theme.of(context).colorScheme.primary,
                                activeTrackColor:pro.isDark? Colors.grey[200]:Colors.grey[300],
                                inactiveTrackColor:pro.isDark? Colors.grey:Colors.white,
                                inactiveThumbColor:pro.isDark?Colors.white:Colors.black ,
                                value: pro.isDark,
                                onChanged: (value) {
                                  pro.isDark = value;
                                  if (pro.isDark == true) {
                                    pro.changeMode(ThemeMode.dark);
                                  } else {
                                    pro.changeMode(ThemeMode.light);
                                  }
                                  setState(() {});
                                },
                              )
                            ],
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              ),
            ),
          )),
    ]);
  }
}
