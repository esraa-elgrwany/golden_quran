import 'package:adhan/adhan.dart';
import 'package:assets_audio_player/assets_audio_player.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:islami_project/mythemedata.dart';
import 'package:islami_project/notification/notification.dart';
import 'package:islami_project/pray_row.dart';
import 'package:islami_project/providers/my_provider.dart';
import 'package:provider/provider.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

import 'Hive_Service.dart';

class PrayTimesScreen extends StatefulWidget {
  static const String routeName = "PrayTimes";

  const PrayTimesScreen({super.key});

  @override
  State<PrayTimesScreen> createState() => _PrayTimesScreenState();
}

class _PrayTimesScreenState extends State<PrayTimesScreen> {
  bool isSwitched = false;
  @override
  void initState() {
    super.initState();
    loadSwitchState();
  }

  Future<void> loadSwitchState() async {
    isSwitched = await HiveService.getSwitchState('praySwitch');
    setState(() {
    });
  }
  @override
  Widget build(BuildContext context) {
    var pro = Provider.of<MyProvider>(context);

    final coordinates = Coordinates(30.0444, 31.2357);
    final params = CalculationMethod.karachi.getParameters();
    params.madhab = Madhab.shafi;
    final prayerTimes = PrayerTimes.today(coordinates, params);
    return Stack(
      children: [
        Image.asset(
          "assets/images/LPrayTime.jpg",
          fit: BoxFit.fill,
          height: MediaQuery.of(context).size.height,
        ),
        Scaffold(
          backgroundColor: pro.isDark
              ? MyThemeData.darkPrimary.withOpacity(.9)
              : Colors.transparent,
          appBar: AppBar(
            leading: Container(
              padding: const EdgeInsets.all(4),
              child: Center(
                child: IconButton(
                    onPressed: () {
                      Navigator.pop(context);
                    },
                    icon: Icon(
                      Icons.arrow_back_rounded,
                      size: 30,
                      color: Theme.of(context).colorScheme.surface,
                    )),
              ),
            ),
            actions: [
              Padding(
                padding: const EdgeInsets.all(8),
                child: Switch(
                    activeColor: Theme.of(context).colorScheme.primary,
                    activeTrackColor: Colors.grey[100],
                    inactiveTrackColor:
                        pro.isDark ? Colors.grey : Colors.grey[200],
                    value: isSwitched,
                    onChanged: (value) async{
                      setState(() {
                        isSwitched = value;
                        if (isSwitched) {
                          schedulePrayerTimes(prayerTimes);
                        } else {
                          NotificationService.cancelNotificationsForChannel('channel_IdPray');
                        }
                      });
                      await HiveService.saveSwitchState('praySwitch', value);
                    }),
              ),
            ],
          ),
          body: Center(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                SizedBox(
                  height: 16,
                ),
                Text("مواقيت الصلاة",
                    style: Theme.of(context).textTheme.bodyLarge!.copyWith(
                          color: Theme.of(context).colorScheme.onBackground,
                        )),
                SizedBox(
                  height: 12,
                ),
                Padding(
                  padding: const EdgeInsets.all(12),
                  child: Center(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        PrayRow(
                          txt: "الفجر",
                          icon: Icon(Icons.sunny_snowing),
                          time: DateFormat.jm().format(prayerTimes.fajr),
                        ),
                        PrayRow(
                          txt: "الصبح",
                          icon: Icon(Icons.wb_cloudy_outlined),
                          time: DateFormat.jm().format(prayerTimes.sunrise),
                        ),
                        PrayRow(
                          txt: "الظهر",
                          icon: Icon(Icons.wb_sunny_rounded),
                          time: DateFormat.jm().format(prayerTimes.dhuhr),
                        ),
                        PrayRow(
                          txt: "العصر",
                          icon: Icon(Icons.wb_sunny_outlined),
                          time: DateFormat.jm().format(prayerTimes.asr),
                        ),
                        PrayRow(
                          txt: "المغرب",
                          icon: Icon(Icons.mode_night_outlined),
                          time: DateFormat.jm().format(prayerTimes.maghrib),
                        ),
                        PrayRow(
                          txt: "العشاء",
                          icon: Icon(Icons.nights_stay_rounded),
                          time: DateFormat.jm().format(prayerTimes.isha),
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }

  void schedulePrayerTimes(PrayerTimes prayerTimes) {
    NotificationService.schedulePrayerNotification(
      0,
      "Fajr Prayer",
      "Time for Fajr prayer",
      prayerTimes.fajr,
    );
    print("-----------------${prayerTimes.fajr}");
    NotificationService.schedulePrayerNotification(
      1,
      "sunrise Prayer",
      "Time for sunrise prayer",
      prayerTimes.sunrise,
    );
    print("-----------------${prayerTimes.sunrise}");
    NotificationService.schedulePrayerNotification(
      2,
      "Dhuhr Prayer",
      "Time for Dhuhr prayer",
      prayerTimes.dhuhr,
    );
    print("-----------------${prayerTimes.dhuhr}");
    NotificationService.schedulePrayerNotification(3,
      "Asr Prayer",
      "Time for Asr prayer",
      prayerTimes.asr,
    );

    NotificationService.schedulePrayerNotification(4,
      "Maghrib Prayer",
      "Time for Maghrib prayer",
      prayerTimes.maghrib,
    );

    NotificationService.schedulePrayerNotification(5,
      "Isha Prayer",
      "Time for Isha prayer",
      prayerTimes.isha,
    );
  }

}
