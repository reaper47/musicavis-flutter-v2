import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:musicavis/utils/constants.dart';

final themeStateNotifier = StateNotifierProvider((ref) => ThemeState());

class ThemeState extends StateNotifier<String> {
  ThemeState() : super(BLACK_THEME_PREF);

  void setTheme(String name) => state = name;
}
