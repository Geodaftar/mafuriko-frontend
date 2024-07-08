/// GENERATED CODE - DO NOT MODIFY BY HAND
/// *****************************************************
///  FlutterGen
/// *****************************************************

// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: directives_ordering,unnecessary_import,implicit_dynamic_list_literal,deprecated_member_use

import 'package:flutter/widgets.dart';

class $AssetsIconsGen {
  const $AssetsIconsGen();

  /// File path: assets/icons/.keep
  String get aKeep => 'assets/icons/.keep';

  /// List of all assets
  List<String> get values => [aKeep];
}

class $AssetsImagesGen {
  const $AssetsImagesGen();

  /// File path: assets/images/.keep
  String get aKeep => 'assets/images/.keep';

  /// Directory path: assets/images/onboarding
  $AssetsImagesOnboardingGen get onboarding =>
      const $AssetsImagesOnboardingGen();

  /// List of all assets
  List<String> get values => [aKeep];
}

class $AssetsImagesOnboardingGen {
  const $AssetsImagesOnboardingGen();

  /// File path: assets/images/onboarding/Illustration_one.png
  AssetGenImage get illustrationOne =>
      const AssetGenImage('assets/images/onboarding/Illustration_one.png');

  /// File path: assets/images/onboarding/Illustration_three.png
  AssetGenImage get illustrationThree =>
      const AssetGenImage('assets/images/onboarding/Illustration_three.png');

  /// File path: assets/images/onboarding/Illustration_two.png
  AssetGenImage get illustrationTwo =>
      const AssetGenImage('assets/images/onboarding/Illustration_two.png');

  /// List of all assets
  List<AssetGenImage> get values =>
      [illustrationOne, illustrationThree, illustrationTwo];
}

class AppImages {
  AppImages._();

  static const $AssetsIconsGen icons = $AssetsIconsGen();
  static const $AssetsImagesGen images = $AssetsImagesGen();
}

class AssetGenImage {
  const AssetGenImage(
    this._assetName, {
    this.size,
    this.flavors = const {},
  });

  final String _assetName;

  final Size? size;
  final Set<String> flavors;

  Image image({
    Key? key,
    AssetBundle? bundle,
    ImageFrameBuilder? frameBuilder,
    ImageErrorWidgetBuilder? errorBuilder,
    String? semanticLabel,
    bool excludeFromSemantics = false,
    double? scale,
    double? width,
    double? height,
    Color? color,
    Animation<double>? opacity,
    BlendMode? colorBlendMode,
    BoxFit? fit,
    AlignmentGeometry alignment = Alignment.center,
    ImageRepeat repeat = ImageRepeat.noRepeat,
    Rect? centerSlice,
    bool matchTextDirection = false,
    bool gaplessPlayback = false,
    bool isAntiAlias = false,
    String? package,
    FilterQuality filterQuality = FilterQuality.low,
    int? cacheWidth,
    int? cacheHeight,
  }) {
    return Image.asset(
      _assetName,
      key: key,
      bundle: bundle,
      frameBuilder: frameBuilder,
      errorBuilder: errorBuilder,
      semanticLabel: semanticLabel,
      excludeFromSemantics: excludeFromSemantics,
      scale: scale,
      width: width,
      height: height,
      color: color,
      opacity: opacity,
      colorBlendMode: colorBlendMode,
      fit: fit,
      alignment: alignment,
      repeat: repeat,
      centerSlice: centerSlice,
      matchTextDirection: matchTextDirection,
      gaplessPlayback: gaplessPlayback,
      isAntiAlias: isAntiAlias,
      package: package,
      filterQuality: filterQuality,
      cacheWidth: cacheWidth,
      cacheHeight: cacheHeight,
    );
  }

  ImageProvider provider({
    AssetBundle? bundle,
    String? package,
  }) {
    return AssetImage(
      _assetName,
      bundle: bundle,
      package: package,
    );
  }

  String get path => _assetName;

  String get keyName => _assetName;
}
