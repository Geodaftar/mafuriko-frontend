import 'package:flutter/material.dart';

import 'package:mafuriko/gen/colors.gen.dart';

import 'app_app_bar_theme.dart';
import 'app_color_scheme.dart';
import 'app_elevated_button_theme.dart';
import 'app_text_button_theme.dart';
import 'app_text_theme.dart';

class AppTheme {
  static final ThemeData theme = ThemeData.light(useMaterial3: true).copyWith(
    colorScheme: AppColorScheme.appColorSchemeLight,
    textTheme: appTextThemeLight,
    scaffoldBackgroundColor: AppColor.white,
    elevatedButtonTheme: appElevatedButtonThemeLight,
    textButtonTheme: appTextButtonThemeLight,
    appBarTheme: appAppBarTheme,
  );
}
