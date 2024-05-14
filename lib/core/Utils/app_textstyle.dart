import 'package:oriksha_application/core/Utils/color_constant.dart';
import 'package:flutter/material.dart';

abstract class AppStyle {
  static const String defaultFontOfApp = 'Exo2';
  static const String _defaultFontFamily = 'Exo2';
  static const FontWeight _defaultFontWeight = FontWeight.w400;

  static TextStyle style(double size,
      {Color? fontColor,
        String? fontFamily,
        FontWeight? fontWeight,
        Color? decorationColor}) {
    const defaultFontColor =ColorConstant.primaryBlack;
    return TextStyle(
        decorationColor: defaultFontColor,
        fontWeight: fontWeight ?? _defaultFontWeight,
        fontSize: size,
        color: fontColor ?? defaultFontColor);
  }
}