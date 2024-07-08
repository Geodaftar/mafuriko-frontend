import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:mafuriko/shared/theme/app_color_scheme.dart';
import 'package:mafuriko/shared/theme/app_text_theme.dart';

final appElevatedButtonThemeLight = ElevatedButtonThemeData(
  style: ElevatedButton.styleFrom(
    shape: RoundedRectangleBorder(
      borderRadius: BorderRadius.circular(10.r),
    ),
    padding: EdgeInsets.symmetric(
      vertical: 17.h,
      horizontal: 14.h,
    ),
    elevation: 0,
    textStyle: appTextThemeLight.titleMedium?.copyWith(
      color: AppColorScheme.appColorSchemeLight.onPrimary,
      fontSize: 20.spMin,
      fontWeight: FontWeight.w800,
    ),
    foregroundColor: AppColorScheme.appColorSchemeLight.surface,
    backgroundColor: AppColorScheme.primary,
    disabledForegroundColor:
        AppColorScheme.appColorSchemeLight.onSurface.withOpacity(0.38),
    disabledBackgroundColor:
        AppColorScheme.appColorSchemeLight.onSurface.withOpacity(0.12),
    shadowColor: AppColorScheme.appColorSchemeLight.shadow,
    surfaceTintColor: AppColorScheme.appColorSchemeLight.surfaceTint,
  ),
);
