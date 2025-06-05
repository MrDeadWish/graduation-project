import 'package:binevir/constants/theme_colors.dart';
import 'package:flutter/material.dart';

class AppTheme {
  static ThemeData get lightTheme {
    return ThemeData(
      scaffoldBackgroundColor: ThemeColors.white,
      fontFamily: 'Golos',
      primaryColor: ThemeColors.red,
      primarySwatch: Colors.red,
      hintColor: ThemeColors.red,
       colorScheme: ColorScheme.fromSwatch(
    primarySwatch: Colors.red,
  ).copyWith(
    secondary: ThemeColors.red,
  ),
      elevatedButtonTheme: ElevatedButtonThemeData(
        style: ButtonStyle(
          minimumSize: MaterialStateProperty.all(
            const Size(155, 30),
          ),
          elevation: MaterialStateProperty.all(0),
          shape: MaterialStateProperty.resolveWith<OutlinedBorder>((_) {
            return RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(5));
          }),
        ),
      ),
      bottomNavigationBarTheme: BottomNavigationBarThemeData(
        elevation: 0,
        showUnselectedLabels: true,
        backgroundColor: const Color.fromRGBO(216, 217, 217, 1),
        unselectedItemColor: const Color.fromRGBO(87, 86, 86, 1),
        selectedItemColor: ThemeColors.red,
        unselectedIconTheme: const IconThemeData(),
        unselectedLabelStyle: const TextStyle(
          fontSize: 10.8,
        ),
        selectedLabelStyle: const TextStyle(
          fontSize: 10.8,
        ),
      ),
      buttonTheme: ButtonThemeData(
        minWidth: 155,
        padding: const EdgeInsets.all(0),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(18.0),
        ),
        buttonColor: ThemeColors.white,
      ),
      checkboxTheme: CheckboxThemeData(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(5),
        ),
      ),
      inputDecorationTheme: InputDecorationTheme(
        isDense: true,
        contentPadding:
            const EdgeInsets.symmetric(horizontal: 13.0, vertical: 5.0),
        hintStyle: const TextStyle(
          color: Color.fromRGBO(217, 217, 217, 1),
        ),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(5.0),
          borderSide: const BorderSide(
            color: Color.fromRGBO(217, 217, 217, 1),
          ),
        ),
      ),
      textTheme: const TextTheme(
        bodySmall: TextStyle(
          fontSize: 14,
          fontFamily: 'Golos',
        ),
        titleMedium: TextStyle(
          fontSize: 14.0,
          height: 1.214,
          fontWeight: FontWeight.w400,
          fontFamily: 'Golos',
        ),
        displayLarge: TextStyle(
          fontFamily: 'Golos',
          fontSize: 18.0,
          height: 1.2,
          fontWeight: FontWeight.w600,
        ),
        headlineMedium: TextStyle(
          fontFamily: 'Golos',
          fontSize: 18.0,
          fontWeight: FontWeight.w400,
        ),
        headlineSmall: TextStyle(
          fontFamily: 'Golos',
          fontSize: 16.0,
          height: 1.1875,
          fontWeight: FontWeight.w400,
        ),
        titleLarge: TextStyle(
          fontFamily: 'Golos',
          fontSize: 14.0,
          fontWeight: FontWeight.w400,
        ),
        labelLarge: TextStyle(
          fontSize: 14.0,
          height: 1.2,
          fontWeight: FontWeight.w500,
          fontFamily: 'Golos',
        ),
        bodyLarge: TextStyle(
          fontSize: 12.0,
          fontFamily: 'Golos',
        ),
        bodyMedium: TextStyle(
          fontSize: 14.0,
          fontFamily: 'Golos',
        ),
      ),
    );
  }


static ThemeData get darkTheme {
  return ThemeData(
    scaffoldBackgroundColor: Colors.black,
    fontFamily: 'Golos',
    primaryColor: ThemeColors.red,
    primarySwatch: Colors.red,
    hintColor: ThemeColors.red,
     colorScheme: ColorScheme.fromSwatch(
    primarySwatch: Colors.red,
  ).copyWith(
    secondary: ThemeColors.red,
  ),
    elevatedButtonTheme: ElevatedButtonThemeData(
      style: ButtonStyle(
        minimumSize: MaterialStateProperty.all(
          const Size(155, 30),
        ),
        elevation: MaterialStateProperty.all(0),
        shape: MaterialStateProperty.resolveWith<OutlinedBorder>((_) {
          return RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(5),
          );
        }),
      ),
    ),
    bottomNavigationBarTheme: BottomNavigationBarThemeData(
      elevation: 0,
      showUnselectedLabels: true,
      backgroundColor: const Color.fromRGBO(48, 48, 48, 1),
      unselectedItemColor: Colors.grey,
      selectedItemColor: ThemeColors.red,
      unselectedIconTheme: const IconThemeData(),
      unselectedLabelStyle: const TextStyle(
        fontSize: 10.8,
      ),
      selectedLabelStyle: const TextStyle(
        fontSize: 10.8,
      ),
    ),
    buttonTheme: ButtonThemeData(
      minWidth: 155,
      padding: const EdgeInsets.all(0),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(18.0),
      ),
      buttonColor: Colors.black,
    ),
    checkboxTheme: CheckboxThemeData(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(5),
      ),
    ),
    inputDecorationTheme: InputDecorationTheme(
      isDense: true,
      contentPadding:
          const EdgeInsets.symmetric(horizontal: 13.0, vertical: 5.0),
      hintStyle: const TextStyle(color: Colors.grey),
      border: OutlineInputBorder(
        borderRadius: BorderRadius.circular(5.0),
        borderSide: const BorderSide(color: Colors.grey),
      ),
    ),
    textTheme: const TextTheme(
      bodySmall: TextStyle(fontSize: 14, fontFamily: 'Golos', color: Colors.white),
      titleMedium: TextStyle(fontSize: 14.0, height: 1.214, fontWeight: FontWeight.w400, fontFamily: 'Golos', color: Colors.white),
      displayLarge: TextStyle(fontFamily: 'Golos', fontSize: 18.0, height: 1.2, fontWeight: FontWeight.w600, color: Colors.white),
      headlineMedium: TextStyle(fontFamily: 'Golos', fontSize: 18.0, fontWeight: FontWeight.w400, color: Colors.white),
      headlineSmall: TextStyle(fontFamily: 'Golos', fontSize: 16.0, height: 1.1875, fontWeight: FontWeight.w400, color: Colors.white),
      titleLarge: TextStyle(fontFamily: 'Golos', fontSize: 14.0, fontWeight: FontWeight.w400, color: Colors.white),
      labelLarge: TextStyle(fontSize: 14.0, height: 1.2, fontWeight: FontWeight.w500, fontFamily: 'Golos', color: Colors.white),
      bodyLarge: TextStyle(fontSize: 12.0, fontFamily: 'Golos', color: Colors.white),
      bodyMedium: TextStyle(fontSize: 14.0, fontFamily: 'Golos', color: Colors.white),
    ),
  );
}

}
