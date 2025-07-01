import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:islami_project/ahadethmodel.dart';
import 'package:islami_project/providers/my_provider.dart';
import 'package:provider/provider.dart';

import 'mythemedata.dart';

class HadethDetails extends StatefulWidget{
  static const String routeName="hadethDetails";

  @override
  State<HadethDetails> createState() => _HadethDetailsState();
}

class _HadethDetailsState extends State<HadethDetails> {
  @override
  Widget build(BuildContext context) {
    var provider=Provider.of<MyProvider>(context);
    var args=ModalRoute.of(context)?.settings.arguments as AhadethModel;
    return Stack(
      children: [
        Image.asset(
          provider.getBackground(),
          fit: BoxFit.fill,
          width: double.infinity,
        ),
        Scaffold(
          appBar: AppBar(
            title: Text(
              args.title,
              style: Theme.of(context).textTheme.bodyLarge,
            ),
          ),
          body: Padding(
            padding: const EdgeInsets.all(12),
            child: Card(
              color: provider.modeApp==ThemeMode.light?
           Colors.white.withOpacity(.9)
        : Colors.white.withOpacity(.2),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(12),
                side: BorderSide(color: Theme.of(context).colorScheme.primary,
                    ),
              ),
              child: Padding(
                padding: const EdgeInsets.all(24),
                child: ListView.separated(
                  separatorBuilder: (context, index) => Divider(
                    color: Theme.of(context).colorScheme.surface,
                    thickness: 1,
                    indent: 40,
                    endIndent: 40,
                  ),
                  itemBuilder: (context, index) {
                    return Center(
                        child: Text(args.content[index],
                          style: Theme.of(context).textTheme.bodySmall!.copyWith(
                          color: provider.modeApp==ThemeMode.light?MyThemeData.blackColor:
                          Colors.white,
                          ),
                          textAlign: TextAlign.center,
                          textDirection: TextDirection.rtl,
                        ));
                  },
                  itemCount:args.content.length ,
                ),
              ),
            ),
          ),
        ),
      ],
    );

  }
}