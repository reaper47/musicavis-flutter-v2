import 'package:flutter/material.dart';

const BLACK_THEME_PREF = 'Black';
const DARK_THEME_PREF = 'Dark';
const LIGHT_THEME_PREF = 'Light';

const double defaultFontSize = 16;
const double biggerFontSize = defaultFontSize + 2;
const double smallFontSize = defaultFontSize - 2;

const bigTextStyle = const TextStyle(fontSize: biggerFontSize);

final greyTextStyle = (double fontSize) => TextStyle(
      fontSize: fontSize,
      color: Colors.grey,
    );

final themesList = [LIGHT_THEME_PREF, DARK_THEME_PREF, BLACK_THEME_PREF];

class AppTheme {
  AppTheme._();

  static final dark = ThemeData.dark();
  static final light = ThemeData.light();

  static final black = ThemeData(
    accentColor: Colors.red[400],
    brightness: Brightness.dark,
    canvasColor: Colors.black,
    dialogBackgroundColor: Color(0xFF2C2C2C),
    dividerColor: Color(0xFF323232),
    cardTheme: CardTheme(
      color: Colors.black,
      shadowColor: Colors.red,
    ),
    primaryColor: Colors.black,
    popupMenuTheme: PopupMenuThemeData(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(6),
        side: BorderSide(color: Color(0xFF323232)),
      ),
    ),
    scaffoldBackgroundColor: Colors.black,
  );
}

ThemeData getTheme(String name) {
  switch (name) {
    case BLACK_THEME_PREF:
      return AppTheme.black;
    case LIGHT_THEME_PREF:
      return AppTheme.light;
    case DARK_THEME_PREF:
      return AppTheme.dark;
    default:
      return AppTheme.light;
  }
}
