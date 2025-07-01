import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:islami_project/mythemedata.dart';
import 'package:islami_project/notification/notification.dart';
import 'package:islami_project/providers/my_provider.dart';
import 'package:islami_project/tabs/settingtab.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:provider/provider.dart';

import 'Hive_Service.dart';

class Morning extends StatefulWidget {
  static const String routeName = "morning";

  const Morning({super.key});

  @override
  State<Morning> createState() => _MorningState();
}

class _MorningState extends State<Morning> {
  bool isSwitched = false;
  DateTime selectedTime = DateTime.now();
  final List<String> messages = [
    "أَصْـبَحْنا وَأَصْـبَحَ المُـلْكُ لله وَالحَمدُ لله ، لا إلهَ إلاّ اللّهُ وَحدَهُ لا شَريكَ لهُ، لهُ المُـلكُ ولهُ الحَمْـد، وهُوَ على كلّ شَيءٍ قدير ، رَبِّ أسْـأَلُـكَ خَـيرَ ما في هـذا اليوم وَخَـيرَ ما بَعْـدَه ، وَأَعـوذُ بِكَ مِنْ شَـرِّ ما في هـذا اليوم وَشَرِّ ما بَعْـدَه، رَبِّ أَعـوذُبِكَ مِنَ الْكَسَـلِ وَسـوءِ الْكِـبَر ، رَبِّ أَعـوذُ بِكَ مِنْ عَـذابٍ في النّـارِ وَعَـذابٍ في القَـبْر.",
    "اللّهـمَّ أَنْتَ رَبِّـي لا إلهَ إلاّ أَنْتَ ، خَلَقْتَنـي وَأَنا عَبْـدُك ، وَأَنا عَلـى عَهْـدِكَ وَوَعْـدِكَ ما اسْتَـطَعْـت ، أَعـوذُبِكَ مِنْ شَـرِّ ما صَنَـعْت ، أَبـوءُ لَـكَ بِنِعْـمَتِـكَ عَلَـيَّ وَأَبـوءُ بِذَنْـبي فَاغْفـِرْ لي فَإِنَّـهُ لا يَغْـفِرُ الذُّنـوبَ إِلاّ أَنْتَ .",
    "رَضيـتُ بِاللهِ رَبَّـاً وَبِالإسْلامِ ديـناً وَبِمُحَـمَّدٍ صلى الله عليه وسلم نَبِيّـاً.",
    "للّهُـمَّ إِنِّـي أَصْبَـحْتُ أُشْـهِدُك ، وَأُشْـهِدُ حَمَلَـةَ عَـرْشِـك ، وَمَلَائِكَتَكَ ، وَجَمـيعَ خَلْـقِك ، أَنَّـكَ أَنْـتَ اللهُ لا إلهَ إلاّ أَنْـتَ وَحْـدَكَ لا شَريكَ لَـك ، وَأَنَّ ُ مُحَمّـداً عَبْـدُكَ وَرَسـولُـك.",
    "اللّهُـمَّ ما أَصْبَـَحَ بي مِـنْ نِعْـمَةٍ أَو بِأَحَـدٍ مِـنْ خَلْـقِك ، فَمِـنْكَ وَحْـدَكَ لا شريكَ لَـك ، فَلَـكَ الْحَمْـدُ وَلَـكَ الشُّكْـر.",
    "حَسْبِـيَ اللّهُ لا إلهَ إلاّ هُوَ عَلَـيهِ تَوَكَّـلتُ وَهُوَ رَبُّ العَرْشِ العَظـيم.",
    "بِسـمِ اللهِ الذي لا يَضُـرُّ مَعَ اسمِـهِ شَيءٌ في الأرْضِ وَلا في السّمـاءِ وَهـوَ السّمـيعُ العَلـيم.",
    "اللّهُـمَّ بِكَ أَصْـبَحْنا وَبِكَ أَمْسَـينا ، وَبِكَ نَحْـيا وَبِكَ نَمُـوتُ وَإِلَـيْكَ النُّـشُور.",
    "أَصْبَـحْـنا عَلَى فِطْرَةِ الإسْلاَمِ، وَعَلَى كَلِمَةِ الإِخْلاَصِ، وَعَلَى دِينِ نَبِيِّنَا مُحَمَّدٍ صَلَّى اللهُ عَلَيْهِ وَسَلَّمَ، وَعَلَى مِلَّةِ أَبِينَا إبْرَاهِيمَ حَنِيفاً مُسْلِماً وَمَا كَانَ مِنَ المُشْرِكِينَ.",
    "سُبْحـانَ اللهِ وَبِحَمْـدِهِ عَدَدَ خَلْـقِه ، وَرِضـا نَفْسِـه ، وَزِنَـةَ عَـرْشِـه ، وَمِـدادَ كَلِمـاتِـه."
  ];
  String? endItemsValue;
  String? separateItemsValue;
  final List<String> endItems = ["نص ساعة", "ساعة", 'ساعتين'];
  final List<String> separateItems = ["دقيقة", 'دقيقتين'];

  @override
  void initState() {
    super.initState();
    loadMorningSettings();
  }

  Future<void> loadMorningSettings() async {

      isSwitched = await HiveService.getSwitchState('morningSwitch');
      selectedTime = await HiveService.getTime('morningSelectedTime') ?? DateTime.now();
      endItemsValue = await HiveService.getEndTime('morningEndItemsValue') ?? 'ساعة';
      separateItemsValue = await HiveService.getSeparateTime('morningSeparateItemsValue') ?? 'دقيقة';
   setState(() {
   });
  }

  @override
  Widget build(BuildContext context) {
    print(TimeOfDay.now());
    var pro = Provider.of<MyProvider>(context);
    return Stack(
      children: [
        Image.asset(
          pro.getBackground(),
          width: double.infinity,
          fit: BoxFit.cover,
        ),
        Scaffold(
            appBar: AppBar(
              title: Text("أذكار الصباح",
                  style: Theme.of(context).textTheme.bodyLarge),
            ),
            body: Column(
              children: [
                SizedBox(
                  height: 20,
                ),
                Container(
                  height: 170.h,
                  width: double.infinity,
                  margin: EdgeInsetsDirectional.all(12),
                  padding: EdgeInsets.all(12),
                  decoration: BoxDecoration(
                      color:
                          Theme.of(context).colorScheme.primary.withOpacity(.7),
                      borderRadius: BorderRadiusDirectional.circular(16)),
                  child: Center(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Row(
                          children: [
                            Text("تفعيل الاشعارات",
                                style: Theme.of(context).textTheme.bodySmall),
                            Spacer(),
                            Switch(
                                activeColor:
                                    Theme.of(context).colorScheme.primary,
                                activeTrackColor: Colors.grey[100],
                                inactiveTrackColor:
                                    pro.isDark ? Colors.grey : Colors.grey[200],
                                value: isSwitched,
                                onChanged: (value) async {
                                  setState(() {
                                    isSwitched = value;
                                    if (isSwitched) {
                                      NotificationService.scheduleNotification(
                                          messages,
                                          selectedTime,
                                          NotificationService
                                              .intervalBetweenNotifications,
                                          NotificationService.endTime);
                                      print(
                                          "***************${NotificationService.scheduleNotification}");
                                    } else {
                                       NotificationService.cancelNotificationsForChannel('channel_IdMorning');
                                    }
                                  });
                                  await HiveService.saveSwitchState('morningSwitch', value);
                                  print(
                                      "***************${isSwitched}");
                                }),
                          ],
                        ),
                        Row(
                          children: [
                            Row(
                              children: [
                                Text(" الوقت المحدد لارسال الاشعارات  ",
                                    style: Theme.of(context)
                                        .textTheme
                                        .bodySmall!
                                        .copyWith(
                                          fontSize: 14,
                                        )),
                                Text("${selectedTime.minute}:",
                                    style: Theme.of(context)
                                        .textTheme
                                        .bodySmall!
                                        .copyWith(
                                          fontSize: 16,
                                        )),
                                Text(
                                    selectedTime.hour == 00
                                        ? "12"
                                        : selectedTime.hour > 12
                                            ? "${selectedTime.hour - 12}"
                                            : "${selectedTime.hour}",
                                    style: Theme.of(context)
                                        .textTheme
                                        .bodySmall!
                                        .copyWith(
                                          fontSize: 16,
                                        )),
                                SizedBox(
                                  width: 6.w,
                                ),
                                Text(
                                    selectedTime.hour == 00
                                        ? "AM"
                                        : selectedTime.hour >= 12
                                            ? "PM"
                                            : "AM",
                                    style: Theme.of(context)
                                        .textTheme
                                        .bodySmall!
                                        .copyWith(
                                          fontSize: 16,
                                        )),
                              ],
                            ),
                            Spacer(),
                            InkWell(
                                onTap: () {
                                  pickTime();
                                },
                                child: Icon(
                                  Icons.date_range,
                                  color:
                                      Theme.of(context).colorScheme.secondary,
                                  size: 25,
                                ))
                          ],
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text("وقت الانتهاء:",
                                style: Theme.of(context)
                                    .textTheme
                                    .bodySmall!
                                    .copyWith(
                                      fontSize: 10,
                                    )),
                            DropdownButton<String>(
                              value: endItemsValue,
                              items: endItems.map((String item) {
                                return DropdownMenuItem<String>(
                                  value: item,
                                  child: Text(item),
                                );
                              }).toList(),
                              onChanged: (String? newValue) async {
                                setState(() {
                                  endItemsValue = newValue;
                                  if (newValue == endItems[0]) {
                                    NotificationService.endTime =
                                        selectedTime.add(Duration(minutes: 30));
                                  } else if (newValue == endItems[1]) {
                                    NotificationService.endTime =
                                        selectedTime.add(Duration(hours: 1));
                                  } else {
                                    NotificationService.endTime =
                                        selectedTime.add(Duration(hours: 2));
                                  }
                                });
                                await HiveService.saveEndTime('morningEndItemsValue',endItemsValue!);
                              },
                              dropdownColor:
                                  Theme.of(context).colorScheme.surface,

                              style: TextStyle(
                                  color: Theme.of(context)
                                      .colorScheme
                                      .onBackground),
                              icon: Center(
                                child: Icon(Icons.arrow_drop_down,
                                    color: Theme.of(context)
                                        .colorScheme
                                        .secondary),
                              ),
                            ),
                            Text("الفاصل بين الاشعارات:",
                                style: Theme.of(context)
                                    .textTheme
                                    .bodySmall!
                                    .copyWith(
                                      fontSize: 10,
                                    )),
                            InkWell(
                              onTap: () {},
                              child: DropdownButton<String>(
                                value: separateItemsValue,
                                items: separateItems.map((String item) {
                                  return DropdownMenuItem<String>(
                                    value: item,
                                    child: Text(item),
                                  );
                                }).toList(),
                                onChanged: (String? newValue) async {
                                  setState(() {
                                    separateItemsValue = newValue;
                                    if (newValue == separateItems[0]) {
                                      NotificationService
                                              .intervalBetweenNotifications =
                                          Duration(minutes: 1);
                                    } else {
                                      NotificationService
                                              .intervalBetweenNotifications =
                                          Duration(minutes: 2);
                                    }
                                  });
                                  await HiveService.saveSeparateTime('morningSeparateItemsValue',separateItemsValue!);
                                },
                                dropdownColor:
                                    Theme.of(context).colorScheme.surface,
                                // Background color of dropdown
                                style: TextStyle(
                                    color: Theme.of(context)
                                        .colorScheme
                                        .onBackground),
                                icon: Center(
                                  child: Icon(Icons.arrow_drop_down,
                                      color: Theme.of(context)
                                          .colorScheme
                                          .secondary),
                                ), // Dropdown icon
                              ),
                            ),
                          ],
                        )
                      ],
                    ),
                  ),
                ),
                Expanded(
                  child: ListView.builder(
                    itemBuilder: (context, index) => Container(
                      margin: EdgeInsetsDirectional.all(12),
                      padding: EdgeInsets.all(16),
                      decoration: BoxDecoration(
                          color: Theme.of(context)
                              .colorScheme
                              .primary
                              .withOpacity(.7),
                          borderRadius: BorderRadiusDirectional.circular(16)),
                      child: Text(messages[index],
                          style: Theme.of(context)
                              .textTheme
                              .bodySmall!
                              .copyWith(fontSize: 18)),
                    ),
                    itemCount: messages.length,
                  ),
                ),
              ],
            )),
      ],
    );
  }

  Future<void> pickTime() async {
    final TimeOfDay? timeOfDay = await showTimePicker(
      context: context,
      initialTime: TimeOfDay(
        hour: selectedTime.hour,
        minute: selectedTime.minute,
      ),
      initialEntryMode: TimePickerEntryMode.dial,
      confirmText: 'تاكيد',
      cancelText: 'الغاء',
      builder: (BuildContext context, Widget? child) {
        return Theme(
          data: Theme.of(context).copyWith(
            colorScheme: ColorScheme.light(
              primary: Theme.of(context).colorScheme.primary,
              onSurface: Colors.black,
              onBackground: Theme.of(context).colorScheme.primary,
            ),
          ),
          child: child!,
        );
      },
    );

    if (timeOfDay != null) {
      setState(() {
        selectedTime = DateTime(
          selectedTime.year,
          selectedTime.month,
          selectedTime.day,
          timeOfDay.hour,
          timeOfDay.minute,
        );
      });
      await HiveService.saveTime('morningSelectedTime',selectedTime);
    }
  }
}
