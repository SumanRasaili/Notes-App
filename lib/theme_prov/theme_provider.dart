import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:notesapp/config/constants.dart';
import 'package:notesapp/core/shared_pref.dart';

final themeProvider = StateNotifierProvider<AppThemeNotifier, ThemeMode>((ref) {
  return AppThemeNotifier();
});

class AppThemeNotifier extends StateNotifier<ThemeMode> {
  AppThemeNotifier() : super(ThemeMode.light) {
    initializeAppTheme();
  }

  initializeAppTheme() async {
    final theme = SharedPref.getBool(AppConstants.darkMode);
    state = theme != true ? ThemeMode.light : ThemeMode.dark;
    print("The theme  after is $state");
  }

  toggleTheme() {
    var newTheme = (state == ThemeMode.dark) ? ThemeMode.light : ThemeMode.dark;
    state = newTheme;
    print("Toggled Theme is $state");
  }
}
