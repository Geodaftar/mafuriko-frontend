/// GENERATED CODE - DO NOT MODIFY BY HAND
/// *****************************************************
///  FlutterGen
/// *****************************************************

// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: directives_ordering,unnecessary_import,implicit_dynamic_list_literal,deprecated_member_use

import 'package:flutter/services.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_svg/flutter_svg.dart' as _svg;
import 'package:vector_graphics/vector_graphics.dart' as _vg;

class $AssetsIconsGen {
  const $AssetsIconsGen();

  /// File path: assets/icons/.keep
  String get aKeep => 'assets/icons/.keep';

  /// File path: assets/icons/Picture.png
  AssetGenImage get picture => const AssetGenImage('assets/icons/Picture.png');

  /// File path: assets/icons/alert_pin.png
  AssetGenImage get alertPinPng =>
      const AssetGenImage('assets/icons/alert_pin.png');

  /// File path: assets/icons/alert_pin.svg
  SvgGenImage get alertPinSvg =>
      const SvgGenImage('assets/icons/alert_pin.svg');

  /// File path: assets/icons/arrow_back.svg
  SvgGenImage get arrowBack => const SvgGenImage('assets/icons/arrow_back.svg');

  /// File path: assets/icons/avatar-3.png
  AssetGenImage get avatar3 => const AssetGenImage('assets/icons/avatar-3.png');

  /// File path: assets/icons/bell-notification.svg
  SvgGenImage get bellNotification =>
      const SvgGenImage('assets/icons/bell-notification.svg');

  /// File path: assets/icons/chat-quote-line.svg
  SvgGenImage get chatQuoteLine =>
      const SvgGenImage('assets/icons/chat-quote-line.svg');

  /// File path: assets/icons/check-icon.png
  AssetGenImage get checkIcon =>
      const AssetGenImage('assets/icons/check-icon.png');

  /// File path: assets/icons/contacts-line.svg
  SvgGenImage get contactsLine =>
      const SvgGenImage('assets/icons/contacts-line.svg');

  /// File path: assets/icons/empty-h.png
  AssetGenImage get emptyH => const AssetGenImage('assets/icons/empty-h.png');

  /// File path: assets/icons/eye.svg
  SvgGenImage get eye => const SvgGenImage('assets/icons/eye.svg');

  /// File path: assets/icons/eye_slash.svg
  SvgGenImage get eyeSlash => const SvgGenImage('assets/icons/eye_slash.svg');

  /// File path: assets/icons/home_icon.svg
  SvgGenImage get homeIcon => const SvgGenImage('assets/icons/home_icon.svg');

  /// File path: assets/icons/lock-2-line.svg
  SvgGenImage get lock2Line =>
      const SvgGenImage('assets/icons/lock-2-line.svg');

  /// File path: assets/icons/logo.png
  AssetGenImage get logo => const AssetGenImage('assets/icons/logo.png');

  /// File path: assets/icons/map_icon.svg
  SvgGenImage get mapIcon => const SvgGenImage('assets/icons/map_icon.svg');

  /// File path: assets/icons/notifications.svg
  SvgGenImage get notifications =>
      const SvgGenImage('assets/icons/notifications.svg');

  /// File path: assets/icons/pass.svg
  SvgGenImage get pass => const SvgGenImage('assets/icons/pass.svg');

  /// File path: assets/icons/profile-line.svg
  SvgGenImage get profileLine =>
      const SvgGenImage('assets/icons/profile-line.svg');

  /// File path: assets/icons/sodexam.png
  AssetGenImage get sodexam => const AssetGenImage('assets/icons/sodexam.png');

  /// File path: assets/icons/verify.svg
  SvgGenImage get verify => const SvgGenImage('assets/icons/verify.svg');

  /// List of all assets
  List<dynamic> get values => [
        aKeep,
        picture,
        alertPinPng,
        alertPinSvg,
        arrowBack,
        avatar3,
        bellNotification,
        chatQuoteLine,
        checkIcon,
        contactsLine,
        emptyH,
        eye,
        eyeSlash,
        homeIcon,
        lock2Line,
        logo,
        mapIcon,
        notifications,
        pass,
        profileLine,
        sodexam,
        verify
      ];
}

class $AssetsImagesGen {
  const $AssetsImagesGen();

  /// Directory path: assets/images/onboarding
  $AssetsImagesOnboardingGen get onboarding =>
      const $AssetsImagesOnboardingGen();
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

  /// File path: assets/images/onboarding/thumb.png
  AssetGenImage get thumb =>
      const AssetGenImage('assets/images/onboarding/thumb.png');

  /// List of all assets
  List<AssetGenImage> get values =>
      [illustrationOne, illustrationThree, illustrationTwo, thumb];
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
    bool gaplessPlayback = true,
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

class SvgGenImage {
  const SvgGenImage(
    this._assetName, {
    this.size,
    this.flavors = const {},
  }) : _isVecFormat = false;

  const SvgGenImage.vec(
    this._assetName, {
    this.size,
    this.flavors = const {},
  }) : _isVecFormat = true;

  final String _assetName;
  final Size? size;
  final Set<String> flavors;
  final bool _isVecFormat;

  _svg.SvgPicture svg({
    Key? key,
    bool matchTextDirection = false,
    AssetBundle? bundle,
    String? package,
    double? width,
    double? height,
    BoxFit fit = BoxFit.contain,
    AlignmentGeometry alignment = Alignment.center,
    bool allowDrawingOutsideViewBox = false,
    WidgetBuilder? placeholderBuilder,
    String? semanticsLabel,
    bool excludeFromSemantics = false,
    _svg.SvgTheme? theme,
    ColorFilter? colorFilter,
    Clip clipBehavior = Clip.hardEdge,
    @deprecated Color? color,
    @deprecated BlendMode colorBlendMode = BlendMode.srcIn,
    @deprecated bool cacheColorFilter = false,
  }) {
    final _svg.BytesLoader loader;
    if (_isVecFormat) {
      loader = _vg.AssetBytesLoader(
        _assetName,
        assetBundle: bundle,
        packageName: package,
      );
    } else {
      loader = _svg.SvgAssetLoader(
        _assetName,
        assetBundle: bundle,
        packageName: package,
        theme: theme,
      );
    }
    return _svg.SvgPicture(
      loader,
      key: key,
      matchTextDirection: matchTextDirection,
      width: width,
      height: height,
      fit: fit,
      alignment: alignment,
      allowDrawingOutsideViewBox: allowDrawingOutsideViewBox,
      placeholderBuilder: placeholderBuilder,
      semanticsLabel: semanticsLabel,
      excludeFromSemantics: excludeFromSemantics,
      colorFilter: colorFilter ??
          (color == null ? null : ColorFilter.mode(color, colorBlendMode)),
      clipBehavior: clipBehavior,
      cacheColorFilter: cacheColorFilter,
    );
  }

  String get path => _assetName;

  String get keyName => _assetName;
}
