import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shared_preferences/shared_preferences.dart';

class ThemeCubit extends Cubit<ThemeMode> {
  final SharedPreferences sharedPreferences;

  ThemeCubit({required this.sharedPreferences}) : super(ThemeMode.system) {
    _loadTheme();
  }

  static const String _themeKey = 'theme_mode';

  void _loadTheme() {
    final savedTheme = sharedPreferences.getString(_themeKey);
    if (savedTheme != null) {
      if (savedTheme == 'light') {
        emit(ThemeMode.light);
      } else if (savedTheme == 'dark') {
        emit(ThemeMode.dark);
      } else {
        emit(ThemeMode.system);
      }
    }
  }

  Future<void> changeTheme(ThemeMode mode) async {
    emit(mode);
    String modeStr = 'system';
    if (mode == ThemeMode.light) modeStr = 'light';
    if (mode == ThemeMode.dark) modeStr = 'dark';
    await sharedPreferences.setString(_themeKey, modeStr);
  }
}
