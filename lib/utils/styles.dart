import 'dart:ui' as ui show Shadow, FontFeature;
import 'package:flutter/material.dart';

class Styles {
  final CustomTextStyle tsBody;
  final CustomTextStyle tsBody1;
  final CustomTextStyle tsBody2;
  final CustomTextStyle tsHeader;
  final CustomTextStyle tsHeader1;
  final CustomTextStyle tsHeader2;
  final CustomTextStyle tsHeader3;

  Styles._({required MaterialColor color})
      : tsBody = CustomTextStyle._(fontSize: 13, color: color.shade700),
        tsBody1 = CustomTextStyle._(fontSize: 15, color: color.shade800),
        tsBody2 = CustomTextStyle._(fontSize: 17, color: color.shade900),
        tsHeader = CustomTextStyle._(fontSize: 19, color: color.shade700),
        tsHeader1 = CustomTextStyle._(fontSize: 23, color: color.shade700),
        tsHeader2 = CustomTextStyle._(fontSize: 30, color: color.shade900),
        tsHeader3 = CustomTextStyle._(fontSize: 38, color: color.shade900);

  /// The instance of [Styles].
  static Styles i = Styles._(color: Colors.brown);
}

class CustomTextStyle extends TextStyle {
  const CustomTextStyle._({
    super.color,
    // super.backgroundColor,
    // super.decorationColor,
    // super.decorationStyle,
    // super.foreground,
    // super.background,
    // super.fontFamily,
    // super.debugLabel,
    // super.fontFamilyFallback,
    super.fontSize,
    // super.textBaseline,
    // super.letterSpacing,
    // super.wordSpacing,
    // super.height,
    // super.locale,
    // super.inherit,
    // super.decoration,
    // super.shadows,
    // super.fontFeatures,
    // super.fontStyle,
    // super.decorationThickness,
    // super.fontWeight,
  });

  TextStyle withValues(
      {Color? color,
      Color? backgroundColor,
      Color? decorationColor,
      TextDecorationStyle? decorationStyle,
      Paint? foreground,
      Paint? background,
      String? fontFamily,
      String? debugLabel,
      List<String>? fontFamilyFallback,
      double? fontSize,
      TextBaseline? textBaseline,
      double? letterSpacing,
      double? wordSpacing,
      double? height,
      Locale? locale,
      bool? inherit,
      TextDecoration? decoration,
      List<ui.Shadow>? shadows,
      List<ui.FontFeature>? fontFeatures,
      FontStyle? fontStyle,
      double? decorationThickness,
      FontWeight? fontWeight}) {
    return TextStyle(
      inherit: inherit ?? this.inherit,
      color: color ?? this.color,
      backgroundColor: backgroundColor ?? this.backgroundColor,
      fontFamily: fontFamily ?? this.fontFamily,
      fontFamilyFallback: fontFamilyFallback ?? this.fontFamilyFallback,
      fontSize: fontSize ?? this.fontSize,
      fontWeight: fontWeight ?? this.fontWeight,
      fontStyle: fontStyle ?? this.fontStyle,
      letterSpacing: letterSpacing ?? this.letterSpacing,
      wordSpacing: wordSpacing ?? this.wordSpacing,
      textBaseline: textBaseline ?? this.textBaseline,
      height: height ?? this.height,
      locale: locale ?? this.locale,
      foreground: foreground ?? this.foreground,
      background: background ?? this.background,
      shadows: shadows ?? this.shadows,
      fontFeatures: fontFeatures ?? this.fontFeatures,
      decoration: decoration ?? this.decoration,
      decorationColor: decorationColor ?? this.decorationColor,
      decorationStyle: decorationStyle ?? this.decorationStyle,
      decorationThickness: decorationThickness ?? this.decorationThickness,
      debugLabel: debugLabel ?? this.debugLabel,
    );
  }
}
