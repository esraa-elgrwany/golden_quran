import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:hive/hive.dart';
import 'package:islami_project/mythemedata.dart';
import 'package:islami_project/providers/my_provider.dart';
import 'package:provider/provider.dart';

class SebhaTab extends StatefulWidget {
  const SebhaTab({super.key});

  @override
  State<SebhaTab> createState() => _SebhaTabState();
}

class _SebhaTabState extends State<SebhaTab> {
  int anime = 0;
  double angle = 0;

  int counter = 0;
  int totalCounter = 0;
  bool click = true;
  Map<String, int> tempCounters = {};
  String selectedZekr = "استغفر الله";
  List<String>azkar = [
    "استغفر الله",
    "سبحان الله",
    "الحمدلله",
    "لا اله الا الله",
    "الله اكبر"
  ];
  final _counterBox = Hive.box("counterBox");
  final _tempCounterBox = Hive.box("tempCounterBox");

  @override
  void initState() {
    super.initState();
    for (var zekr in azkar) {
      tempCounters[zekr] = _tempCounterBox.get(zekr, defaultValue: 0) as int;
    }
    totalCounter = _tempCounterBox.get('totalCounter', defaultValue: 0) as int;
  }

  void incrementCounter(String zekr) {
    setState(() {
      tempCounters[zekr] = (tempCounters[zekr] ?? 0) + 1;
      totalCounter++;
    });
    _tempCounterBox.put(zekr, tempCounters[zekr]);
    _tempCounterBox.put('totalCounter', totalCounter);

    int currentCount = _counterBox.get(zekr, defaultValue: 0);
    _counterBox.put(zekr, currentCount + 1);
  }

  void resetTotalCounter() {
    setState(() {
      for (var zekr in azkar) {
        tempCounters[zekr] = 0;
        _tempCounterBox.put(zekr, 0);
      }
      totalCounter = 0;
      _tempCounterBox.put('totalCounter', 0);
    });
  }


  void showTasbeehLog(BuildContext context) {
    int totalCount = azkar.fold(0, (sum, zekr) {
      return sum + (_counterBox.get(zekr, defaultValue: 0) as int);
    });

    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(15),
          ),
          title: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text("سجل التسبيحات",
                  style: TextStyle(fontSize: 20, color: Colors.black)),
              IconButton(
                icon: Icon(Icons.delete, color: Colors.red),
                onPressed: () {
                  // مسح جميع التسبيحات
                  for (var zekr in azkar) {
                    _counterBox.put(zekr, 0);
                  }
                  setState(() {});
                  Navigator.pop(context); // إغلاق الـ Dialog
                },
              ),
            ],
          ),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              ...azkar.map((zekr) {
                int count = _counterBox.get(zekr, defaultValue: 0);
                return Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(zekr, style: TextStyle(fontSize: 16, color: Colors.black)),
                    Text("$count", style: TextStyle(fontSize: 16, color: Colors.black)),
                  ],
                );
              }).toList(),
              Divider(),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text("إجمالي التسبيحات:",
                      style: TextStyle(fontSize: 16, color: Colors.black)),
                  Text("$totalCount",
                      style: TextStyle(fontSize: 16, color: Colors.black)),
                ],
              ),
            ],
          ),
          actions: [
            TextButton(
              onPressed: () => Navigator.pop(context), // إغلاق الـ Dialog
              child: Text("إغلاق", style: TextStyle(color: Colors.black)),
            ),
          ],
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    var pro = Provider.of<MyProvider>(context);
    //int counterValue = _counterBox.get(selectedZekr, defaultValue: 0);
    return Center(
      child: Column(
        children: [
        Stack(
        alignment: Alignment.topCenter,
        children: [
          Image.asset(
              'assets/images/head_of_seb7a.png',
              color: animateColor(context)),
          Padding(
              padding: EdgeInsets.only(
                  top: MediaQuery
                      .of(context)
                      .size
                      .height * 0.06),
              child: GestureDetector(
                  onTap: () {
                    counter++;
                    incrementCounter(selectedZekr);
                      setState(() {
                        click=!click;
                      });
                      },
                  child: Transform.rotate(
                      angle: angle,
                      child: Image.asset('assets/images/body_of_seb7a.png',
                          color:
                          Theme
                              .of(context)
                              .colorScheme
                              .surface
                      )))),
        ],
      ),
      SizedBox(
        height: 20.h,
      ),
      Text("عدد التسبيحات",
          style: Theme
              .of(context)
              .textTheme
              .bodyMedium!
              .copyWith(
            color: pro.modeApp == ThemeMode.light
                ? MyThemeData.blackColor
                : Colors.white,
            fontWeight: FontWeight.w400,
          )),
      SizedBox(
        height: 14.h,
      ),
      Container(
          width: 60.w,
          height: 60.h,
          decoration: BoxDecoration(
            color: Theme
                .of(context)
                .colorScheme
                .primary
                .withOpacity(.5),
            borderRadius: BorderRadius.circular(24.r),
          ),
          child: Center(
            child: Text(
                "${tempCounters[selectedZekr]}",
              style: Theme
                  .of(context)
                  .textTheme
                  .bodyMedium!
                  .copyWith(
                fontWeight: FontWeight.bold,
                color: pro.modeApp == ThemeMode.light
                    ? MyThemeData.blackColor
                    : Colors.white,
              ),
              textAlign: TextAlign.center,
            ),
          )),
      SizedBox(
        height: 14.h,
      ),
      Center(
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
            children: [
              SizedBox(width: 64,),
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
                selectedZekr,
                style: Theme
                    .of(context)
                    .textTheme
                    .bodySmall!
                    .copyWith(
                  color: pro.modeApp == ThemeMode.light
                      ? Colors.white
                      : MyThemeData.blackColor,
                  fontWeight: FontWeight.bold,
                ),
              ),
            )),
            ),
              SizedBox(width: 40,),
              Container(
                width: 50,
                height: 50,
                decoration: BoxDecoration(
                  color: Theme.of(context).colorScheme.primary,
                  borderRadius: BorderRadius.circular(20.r),
                ),
                child: Center(
                  child: PopupMenuButton<String>(
                    icon: Icon(Icons.arrow_drop_down,size: 35,color: Colors.white,),
                    onSelected: (String? newValue){
                      setState(() {
                        selectedZekr=newValue!;
                      });},
                    itemBuilder: (BuildContext context) {
                      return azkar
                          .map((item) =>
                          PopupMenuItem<String>(
                            value: item,
                            child: Text(item),
                          ))
                          .toList();
                    },
                  ),
                ),
              ),
            ],
            ),
      ),
    SizedBox(height: 10,),
    Padding(
    padding: const EdgeInsets.all(12.0),
    child: Row(
    mainAxisAlignment: MainAxisAlignment.end,
    children: [
      Text("الاجمالي :",style: Theme.of(context).textTheme.bodyMedium!.copyWith(
        color: Theme.of(context).colorScheme.onBackground
      ) ,),
      SizedBox(width: 20,),
      Text("$totalCounter",style: Theme.of(context).textTheme.bodyLarge ),

      Spacer(),
      IconButton(icon: Icon(Icons.replay_circle_filled_rounded,
        color:Theme.of(context).colorScheme.onBackground,size: 40,),
      onPressed: (){
        resetTotalCounter();
      }, ),

    ],
    ),
    ),
          InkWell(
            onTap: () {
              showTasbeehLog( context) ;
            } ,
            child: Container(
              width: 120.w,
              height: 42.h,
              decoration: BoxDecoration(
                color: pro.modeApp == ThemeMode.light
                    ? MyThemeData.primaryColor
                    : MyThemeData.yellow,
                borderRadius: BorderRadius.circular(16.r),
              ),
              child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Center(
                    child: Text(
                      "السجل",
                      style: Theme
                          .of(context)
                          .textTheme
                          .bodySmall!
                          .copyWith(
                        color: pro.modeApp == ThemeMode.light
                            ? Colors.white
                            : MyThemeData.blackColor,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  )),
            ),
          )
        ],
      ),
    );
    }


  animateColor(BuildContext context) {
    Color? changeColor;
    if (anime % 2 == 0) {
      changeColor = Theme
          .of(context)
          .colorScheme
          .surface;
      setState(() {});
      return changeColor;
    }
    if (anime % 2 != 0) {
      changeColor = Theme
          .of(context)
          .colorScheme
          .surface
          .withOpacity(.5);
      setState(() {});
      return changeColor;
    }
  }
}
