import 'package:app/app/core/const.dart';
import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:google_fonts/google_fonts.dart';

class AppWidget extends StatelessWidget {
  const AppWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp.router(
      title: 'My Energy',
      routeInformationParser: Modular.routeInformationParser,
      routerDelegate: Modular.routerDelegate,
      theme: ThemeData(
        primaryColor: ThemeColors.primaryDarkest,
        primaryColorLight: ThemeColors.primaryDark,
        textButtonTheme: TextButtonThemeData(
          style: TextButton.styleFrom(
            foregroundColor: ThemeColors.primaryDarkest,
          ),
        ),
        appBarTheme: const AppBarTheme(
            titleTextStyle: TextStyle(
              fontWeight: FontWeight.bold,
              fontSize: 20,
              color: Color(0xFF1F2024),
            ),
            titleSpacing: 24,
            backgroundColor: Colors.white,
            elevation: 0),
        textTheme: GoogleFonts.interTextTheme(
          Theme.of(context).textTheme,
        ),
        elevatedButtonTheme: ElevatedButtonThemeData(
          style: ElevatedButton.styleFrom(
            backgroundColor: ThemeColors.primaryDarkest,
            elevation: 0,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(8),
              side: BorderSide.none,
            ),
            textStyle: const TextStyle(
              color: ThemeColors.neutralLightLightest,
              fontWeight: FontWeight.w600,
            ),
            foregroundColor: ThemeColors.neutralLightLightest,
            disabledForegroundColor: ThemeColors.neutralLightDarkest,
            disabledBackgroundColor: ThemeColors.neutralLightMedium,
          ),
        ),
        listTileTheme: ListTileThemeData(
          tileColor: ThemeColors.neutralLightLight,
          contentPadding: const EdgeInsets.symmetric(horizontal: 16),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(8),
            side: BorderSide.none,
          ),
        ),
        fontFamily: GoogleFonts.inter().fontFamily,
        snackBarTheme: const SnackBarThemeData(
          backgroundColor: Colors.white,
          contentTextStyle: TextStyle(color: Color(0xFF1F2024)),
        ),
        inputDecorationTheme: InputDecorationTheme(
          fillColor: ThemeColors.neutralLightLight,
          filled: true,
          hintStyle: const TextStyle(
            color: ThemeColors.neutralDarkLightest,
            fontWeight: FontWeight.w300,
            fontSize: 13,
          ),
          contentPadding: const EdgeInsets.symmetric(horizontal: 10),
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(8),
            borderSide: BorderSide.none,
          ),
          enabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(8),
            borderSide: BorderSide.none,
          ),
          focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(8),
            borderSide: const BorderSide(
              color: ThemeColors.primaryLightest,
              width: 2,
            ),
          ),
          focusedErrorBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(8),
            borderSide: const BorderSide(
              color: ThemeColors.errorMedium,
              width: 2,
            ),
          ),
          disabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(8),
            borderSide: const BorderSide(
              color: ThemeColors.neutralLightDarkest,
            ),
          ),
          errorStyle: const TextStyle(
            color: ThemeColors.errorDarkest,
          ),
          errorBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(8),
            borderSide: const BorderSide(
              color: ThemeColors.errorDarkest,
            ),
          ),
        ),
        scaffoldBackgroundColor: Colors.white,
        drawerTheme: const DrawerThemeData(
          backgroundColor: Colors.white,
        ),
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.blue),
        useMaterial3: true,
        chipTheme: const ChipThemeData(
          selectedColor: Color(0xFF3755C1),
          backgroundColor: Color(0xFFF8F9FE),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.all(Radius.circular(8)),
            side: BorderSide(style: BorderStyle.none),
          ),
        ),
      ),
    );
  }
}
