import 'package:flex_seed_scheme/flex_seed_scheme.dart';
import 'package:flutter/material.dart';

class AppColorScheme {
  static const primary = Color(0xFF7A4411);
  static const secondary = Color(0xFF11477A);
  static const tertiary = Color(0xFF000000);
  static const background = Color(0xFFFFF8F0);
  static const white = Color(0xFFFFFFFF);
  static const gray = Color(0xFFEFEFEF);
  static const black = Color(0xFF000000);

  static final ColorScheme appColorSchemeLight = SeedColorScheme.fromSeeds(
    brightness: Brightness.light,
    primaryKey: primary,
    secondaryKey: secondary,
    tertiary: tertiary,
    surface: background,
    tones: FlexTones.vivid(Brightness.light),
  );
}
