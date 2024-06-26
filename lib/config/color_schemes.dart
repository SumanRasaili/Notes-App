import 'package:flutter/material.dart';

const lightColorScheme = ColorScheme(
  brightness: Brightness.light,
  primary: Color(0xFF056D37),
  onPrimary: Color(0xFFFFFFFF),
  primaryContainer: Color(0xFF9CF6B1),
  onPrimaryContainer: Color(0xFF00210C),
  secondary: Color(0xFF286C2A),
  onSecondary: Color(0xFFFFFFFF),
  secondaryContainer: Color(0xFFABF5A3),
  onSecondaryContainer: Color(0xFF002203),
  tertiary: Color(0xFF2E6B27),
  onTertiary: Color(0xFFFFFFFF),
  tertiaryContainer: Color(0xFFAFF49F),
  onTertiaryContainer: Color(0xFF002201),
  error: Color(0xFFBA1A1A),
  errorContainer: Color(0xFFFFDAD6),
  onError: Color(0xFFFFFFFF),
  onErrorContainer: Color(0xFF410002),
  background: Color(0xFFFCFDF7),
  onBackground: Color(0xFF191C19),
  surface: Color(0xFFFCFDF7),
  onSurface: Color(0xFF191C19),
  surfaceVariant: Color(0xFFDDE5DA),
  onSurfaceVariant: Color(0xFF414941),
  outline: Color(0xFF717971),
  onInverseSurface: Color(0xFFF0F1EC),
  inverseSurface: Color(0xFF2E312E),
  inversePrimary: Color(0xFF81D997),
  shadow: Color(0xFF000000),
  surfaceTint: Color(0xFF056D37),
  outlineVariant: Color(0xFFC1C9BF),
  scrim: Color(0xFF000000),
);

const darkColorScheme = ColorScheme(
  brightness: Brightness.dark,
  primary: Color(0xFF81D997),
  onPrimary: Color(0xFF003919),
  primaryContainer: Color(0xFF005227),
  onPrimaryContainer: Color(0xFF9CF6B1),
  secondary: Color(0xFF90D889),
  onSecondary: Color(0xFF003909),
  secondaryContainer: Color(0xFF085314),
  onSecondaryContainer: Color(0xFFABF5A3),
  tertiary: Color(0xFF94D785),
  onTertiary: Color(0xFF003A02),
  tertiaryContainer: Color(0xFF135210),
  onTertiaryContainer: Color(0xFFAFF49F),
  error: Color(0xFFFFB4AB),
  errorContainer: Color(0xFF93000A),
  onError: Color(0xFF690005),
  onErrorContainer: Color(0xFFFFDAD6),
  background: Color(0xFF191C19),
  onBackground: Color(0xFFE2E3DE),
  surface: Color(0xFF191C19),
  onSurface: Color(0xFFE2E3DE),
  surfaceVariant: Color(0xFF414941),
  onSurfaceVariant: Color(0xFFC1C9BF),
  outline: Color(0xFF8B938A),
  onInverseSurface: Color(0xFF191C19),
  inverseSurface: Color(0xFFE2E3DE),
  inversePrimary: Color(0xFF056D37),
  shadow: Color(0xFF000000),
  surfaceTint: Color(0xFF81D997),
  outlineVariant: Color(0xFF414941),
  scrim: Color(0xFF000000),
);

ThemeData lightTheme = ThemeData(
    fontFamily: "Open Sans",
    appBarTheme: const AppBarTheme(
      centerTitle: true,
      color: Colors.white,
    ),
    // iconTheme: IconThemeData(color: lightColorScheme.primary),
    floatingActionButtonTheme: FloatingActionButtonThemeData(
      backgroundColor: lightColorScheme.primary,
      foregroundColor: Colors.white,
    ),
    elevatedButtonTheme: ElevatedButtonThemeData(
        style: ButtonStyle(
            textStyle: MaterialStateProperty.all(
                TextStyle(color: lightColorScheme.background)),
            backgroundColor:
                MaterialStateProperty.all(lightColorScheme.primary))),
    colorScheme: lightColorScheme,
    useMaterial3: true);

ThemeData darkTheme = ThemeData(
    appBarTheme: const AppBarTheme(
      centerTitle: true,
      color: Colors.black,
    ),

    // iconTheme: IconThemeData(color: darksColorScheme.background),
    floatingActionButtonTheme: FloatingActionButtonThemeData(
      backgroundColor: lightColorScheme.primary,
      foregroundColor: Colors.white,
    ),
    elevatedButtonTheme: ElevatedButtonThemeData(
        style: ButtonStyle(
            textStyle: MaterialStateProperty.all(
                TextStyle(color: lightColorScheme.background)),
            backgroundColor:
                MaterialStateProperty.all(lightColorScheme.background))),
    colorScheme: darkColorScheme,
    fontFamily: "Open Sans",
    useMaterial3: true);
