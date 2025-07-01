import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:islami_project/mythemedata.dart';
import 'package:islami_project/providers/my_provider.dart';
import 'package:provider/provider.dart';


class PrayRow extends StatelessWidget{
  String txt;
  Icon icon;
  String time;
   PrayRow({required this.txt,required this.icon,required this.time });

  @override
  Widget build(BuildContext context) {
    var pro=Provider.of<MyProvider>(context);
    return Container(
      width: double.infinity,
      height: 54.h,
      padding: EdgeInsets.all(8),
      margin: EdgeInsets.only(left: 30,right: 30,bottom: 12,top: 12),
      decoration: BoxDecoration(
        color:pro.isDark?MyThemeData.darkPrimary: Color(0XFFcbb471),
        borderRadius: BorderRadiusDirectional.circular(18)
      ),
      child: Row(
        children: [
          Icon(icon.icon,color: Theme.of(context).colorScheme.onBackground ,
            size: 25,),
          SizedBox(width: 16,),
          Text(txt,style: Theme.of(context).textTheme.bodyMedium!.copyWith(
            color: Theme.of(context).colorScheme.onBackground ,
          ),),
          Spacer(),
          Text(time,style: Theme.of(context).textTheme.bodyMedium!.copyWith(
            color: Theme.of(context).colorScheme.onBackground ,
          ),),
        ],
      ),
    );
  }
}
