import 'package:flutter/material.dart';
import 'package:flutter/painting.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:islami_project/morning.dart';
import 'package:islami_project/mythemedata.dart';
import 'package:islami_project/night.dart';
import 'package:islami_project/pray_times.dart';
import 'package:islami_project/providers/my_provider.dart';
import 'package:islami_project/tabs/settingtab.dart';
import 'package:provider/provider.dart';

class ListTab extends StatelessWidget {
  const ListTab({super.key});

  @override
  Widget build(BuildContext context) {
    var pro = Provider.of<MyProvider>(context);
    return Padding(
      padding: const EdgeInsets.all(24),
      child: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            SizedBox(
              height: 20.h,
            ),
            InkWell(
              onTap: () {
                Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => Morning(),
                    ));
              },
              child: Container(
                height: 170.h,
                width: double.infinity,
                padding: EdgeInsets.all(18),
                margin: EdgeInsets.all(12),
                decoration: BoxDecoration(
                    borderRadius: BorderRadiusDirectional.circular(12),
                    color: pro.modeApp == ThemeMode.light
                        ? Colors.white
                        : MyThemeData.darkPrimary,
                    image: DecorationImage(
                      image: AssetImage("assets/images/Lbg.jpg"),
                      fit: BoxFit.cover,
                    )),
                child: Center(
                  child: Text("أذكار الصباح",
                      style: Theme.of(context)
                          .textTheme
                          .bodyLarge!
                          .copyWith(color: MyThemeData.darkPrimary)),
                ),
              ),
            ),
            InkWell(
              onTap: () {
                Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => Night(),
                    ));
              },
              child: Container(
                height: 170.h,
                width: double.infinity,
                padding: EdgeInsets.all(18),
                margin: EdgeInsets.all(12),
                decoration: BoxDecoration(
                    borderRadius: BorderRadiusDirectional.circular(12),
                    color: pro.modeApp == ThemeMode.light
                        ? Colors.white
                        : MyThemeData.darkPrimary,
                    image: DecorationImage(
                      image: AssetImage("assets/images/dbg.jpg"),
                      fit: BoxFit.cover,
                    )),
                child: Center(
                  child: Text("أذكار المساء",
                      style: Theme.of(context)
                          .textTheme
                          .bodyLarge!
                          .copyWith(color: Colors.white)),
                ),
              ),
            ),
            InkWell(
              onTap: () {
                Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => PrayTimesScreen(),
                    ));
              },
              child: Container(
                height: 170.h,
                width: double.infinity,
                padding: EdgeInsets.all(18),
                margin: EdgeInsets.all(12),
                decoration: BoxDecoration(
                    borderRadius: BorderRadiusDirectional.circular(12),
                    color: pro.modeApp == ThemeMode.light
                        ? Colors.white
                        : MyThemeData.darkPrimary,
                    image: DecorationImage(
                      image: AssetImage("assets/images/Lbg.jpg"),
                      fit: BoxFit.cover,
                    )),
                child: Center(
                  child: Text("مواقيت الصلاة",
                      style: Theme.of(context)
                          .textTheme
                          .bodyLarge!
                          .copyWith(color: MyThemeData.darkPrimary)),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
