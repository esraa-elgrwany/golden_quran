import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:islami_project/mythemedata.dart';
import 'package:islami_project/providers/my_provider.dart';
import 'package:provider/provider.dart';

class SebhaTab extends StatefulWidget {
  const SebhaTab({super.key});

  @override
  State<SebhaTab> createState() => _SebhaTabState();
}

class _SebhaTabState extends State<SebhaTab> {
  int index = 0;
  int count = 1;
  int anime = 0;
  double angle = 0;
  List<String> tasbeh = ["سبحان الله", "الحمد لله", "الله اكبر"];

  @override
  Widget build(BuildContext context) {
    var pro = Provider.of<MyProvider>(context);
    return Center(
        child: Column(
      children: [
        Stack(
          alignment: Alignment.topCenter,
          children: [
            Image.asset('assets/images/head_of_seb7a.png', color: animateColor(context)),
            Padding(
                padding: EdgeInsets.only(
                    top: MediaQuery.of(context).size.height * 0.09),
                child: GestureDetector(
                    onTap: () {
                      count++;
                      resetTasbeh();
                      anime++;
                      animateColor(context);
                      setState(() {});
                    },
                    child: Transform.rotate(
                        angle: angle,
                        child: Image.asset('assets/images/body_of_seb7a.png',
                            color: animateColor(context))))),
          ],
        ),
        SizedBox(
          height: 40.h,
        ),
        Text("عدد التسبيحات",
            style: Theme.of(context).textTheme.bodyMedium!.copyWith(
                  color: pro.modeApp == ThemeMode.light
                      ? MyThemeData.blackColor
                      : Colors.white,
                  fontWeight: FontWeight.w400,
                )),
        SizedBox(
          height:34.h,
        ),
        Container(
            width: 69.w,
            height: 81.h,
            decoration: BoxDecoration(
              color: Theme.of(context).colorScheme.primary.withOpacity(.5),
              borderRadius: BorderRadius.circular(30.r),
            ),
            child: Center(
              child: Text(
                "$count",
                style: Theme.of(context).textTheme.bodyMedium!.copyWith(
                      fontWeight: FontWeight.bold,
                      color: pro.modeApp == ThemeMode.light
                          ? MyThemeData.blackColor
                          : Colors.white,
                    ),
                textAlign: TextAlign.center,
              ),
            )),
        SizedBox(
          height:20.h,
        ),
        Container(
          width: 137.w,
          height: 51.h,
          decoration: BoxDecoration(
            color: pro.modeApp == ThemeMode.light
                ? MyThemeData.primaryColor
                : MyThemeData.yellow,
            borderRadius: BorderRadius.circular(20.r),
          ),
          child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Center(
                child: Text(
                  tasbeh[index],
                  style: Theme.of(context).textTheme.bodySmall!.copyWith(
                        color: pro.modeApp == ThemeMode.light
                            ? Colors.white
                            : MyThemeData.blackColor,
                        fontWeight: FontWeight.bold,
                      ),
                ),
              )),
        ),
      ],
    ));
  }

  resetTasbeh() {
    if (index == 2) {
      if (count == 34) {
        index = 0;
        count = 1;
      }
    }
    if (count == 34) {
      count = 1;
      index++;
      setState(() {});
    }
    angle += 360 / 6;
    setState(() {});
  }

  animateColor(BuildContext context) {
    Color? changeColor;
    if (anime % 2 == 0) {
    changeColor = Theme.of(context).colorScheme.surface;
    setState(() {});
    return changeColor;
    }
    if (anime % 2 != 0) {
      changeColor = Theme.of(context).colorScheme.surface.withOpacity(.5);
      setState(() {});
      return changeColor;
    }
  }
}
