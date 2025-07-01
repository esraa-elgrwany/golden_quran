import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';

class MyThemeData{
  static Color primaryColor=Color(0xFFB7935F);
  static Color blackColor=Color(0xFF242424);
  static Color darkPrimary=Color(0xFF141A2E);
  static Color yellow=Color(0xFFFACC1D);

  static ThemeData lightTheme=ThemeData(
    colorScheme: ColorScheme(
        brightness:Brightness.light,
        primary: primaryColor,
        onPrimary: Colors.white,
        secondary:blackColor,
        onSecondary: Colors.white,
        error: Colors.red,
        onError: Colors.white,
        background:primaryColor,
        onBackground: blackColor,
        surface:primaryColor,
        onSurface: Colors.white),
      scaffoldBackgroundColor: Colors.transparent,
      appBarTheme: AppBarTheme(
        iconTheme: IconThemeData(
          color: primaryColor,
        ),
        color: Colors.transparent,
        elevation: 0.0,
        centerTitle: true,
      ),
      textTheme: TextTheme(
        bodySmall: GoogleFonts.elMessiri(
          fontSize: 20.sp,
          fontWeight: FontWeight.w600,
          color: blackColor,
        ),
        bodyMedium: GoogleFonts.elMessiri(
          fontSize: 25.sp,
          fontWeight: FontWeight.w700,
          color:Colors.white,
        ),
        bodyLarge: GoogleFonts.elMessiri(
          fontSize: 30.sp,
          fontWeight: FontWeight.bold,
          color: blackColor,
        ),
      ),
      bottomNavigationBarTheme: BottomNavigationBarThemeData(
        type: BottomNavigationBarType.shifting,
        backgroundColor: primaryColor,
        selectedItemColor: blackColor,
        unselectedItemColor: Colors.white,
  )
  );
  static ThemeData darkTheme=ThemeData(
      colorScheme: ColorScheme(
          brightness:Brightness.dark,
          primary:darkPrimary,
          onPrimary: Colors.white,
          secondary: yellow,
          onSecondary: Colors.white,
          error: Colors.red,
          onError: Colors.white,
          background:Colors.white ,
          onBackground: Colors.white,
          surface: yellow,
          onSurface: Colors.white),
      scaffoldBackgroundColor: Colors.transparent,
      appBarTheme: AppBarTheme(
        iconTheme: IconThemeData(
          color: Colors.white,
        ),
        color: Colors.transparent,
        elevation: 0.0,
        centerTitle: true,
      ),
      textTheme: TextTheme(
        bodySmall: GoogleFonts.elMessiri(
          fontSize: 20.sp,
          fontWeight: FontWeight.w600,
          color:Colors.white,
        ),
        bodyMedium: GoogleFonts.elMessiri(
          fontSize: 25.sp,
          fontWeight: FontWeight.w700,
          color:Colors.yellow,
        ),
        bodyLarge: GoogleFonts.elMessiri(
          fontSize: 30.sp,
          fontWeight: FontWeight.bold,
          color:Colors.white,
        ),
      ),
      bottomNavigationBarTheme: BottomNavigationBarThemeData(
        type: BottomNavigationBarType.shifting,
        backgroundColor: darkPrimary,
        selectedItemColor: yellow,
        unselectedItemColor: Colors.white,
      )
  );
}