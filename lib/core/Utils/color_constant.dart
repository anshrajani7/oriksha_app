import 'package:flutter/material.dart';


extension CustomThemeDataExtension on ThemeData {
  Color get customBackgroundColor  => Colors.grey.shade300;
}
class ColorConstant {

  static const Color primaryWhite = Color(0xFFffffff);
  static const Color green = Color(0xFF028F10);
  static const Color primaryOrg = Color(0xFFF9A519);
  static const Color primaryBlack = Color(0xFF000000);
  static const Color primaryGreen = Color(0xFF1dbf73);
  static const Color greyD3 = Color(0xFFD3D3D3);
  static const Color grey3 = Color(0xFFB3B3B3);
  static const Color black72 = Color(0xFF777272);
  static const Color grey9e = Color(0xFF9E9E9E);
  static const Color greyBorder = Color(0xFF989898);
  static const Color grey = Color(0xFFEFEFEF);
  static const Color greyE0 = Color(0xFFE0E0E0);
  static const Color greyEE = Color(0xFFEEEEEE);
  static const Color greyB3 = Color(0xFFB3B3B3);
  static const Color greyF5 = Color(0xFFF5F5F5);
  static const Color grey72 = Color(0xFF777272);
  static const Color textBlack = Color(0xFF212121);
  static const Color redWithOpecity = Color(0xFFFFEAEA);
  static const Color textGrey75 = Color(0xFF757575);
  static const Color greyFA = Color(0xFFFAFAFA);
  static const Color grey61 = Color(0xFF616161);
  static const Color backGroundColor = Color(0xFFe1e2e3);

  static const Color gradientStartColor = Color(0xFFEE5E5E);
  static const Color btnDarkBackgroundColor = Color(0xFF282727);
  static const Color btnShadowColor = Color(0x47F14A4A);
  static const Color btnDarkShadowColor = Color(0x38282727);
  static const Color blueColor = Color(0xFF2B72FD);
  static const Color blueColorFF = Color(0xFF3C44FF);
  static const Color orange3C = Color(0xFFFF6B3C);
  static const Color orange6C = Color(0xFFFE6C6C);
  static const Color orange38 = Color(0xFFFF3838);
  static const Color gradientEndColor = Color(0xFFE1580A);
  static const Color primaryLightRed = Color(0xFFF14A4A);
  static const Color greyColor72 = Color(0xFF777272);
  static const Color greyColor42 = Color(0xFF424242);
  static const Color greyColorFA = Color(0xFFFAFAFA);
  static const Color redColorE9 = Color(0xFFFFE9E9);
  static const Color greyColorE9= Color(0xFF9E9E9E);
  static const Color greyColorB3 = Color(0xFFB3B3B3);
  static const Color greyColorBE = Color(0xFFBEBEBE);
  static const Color greyColord3 = Color(0xFFD3D3D3);
  static const Color greyColorF5 = Color(0xFFF5F5F5);
  static const Color greyColor8D = Color(0xFF7D828D);
  static const Color greyColor7C = Color(0xFF7C7C7C);
  static const Color greyColor9E = Color(0xFF9E9E9E);
  static const Color primaryOrgDark = Color(0xFFDF1B1B);
  static const Color textGreyColor = Color(0xFF8D919F);
  static const Color cameraBackGroundColor = Color(0xFF292A30);
  static const Color textDarkBrown = Color(0xFF17120D);
  static const Color greyBackGroundColor = Color(0xFFECECEE);
  static const Color lightGrey = Color(0xFFF8FAFC);
  static const Color dividerGreyColor = Color(0xFFF8D919F);
  static const Color borderGreyColor = Color(0xFFF6A6E77);
  static const Color textDarkGreyColor = Color(0xFFF8D919F);
  static const Color bgGrey = Color(0xFFF0F5FA);
  static const Color icGrayColor = Color(0xFF8D919F);
  static const Color transparent = Colors.transparent;
  static const Color greyBack = Color(0xFFF8FAFC  );
  static const Color lightOrange = Color(0xFFFFEDDD);
  static const Color lightOrangeOutline = Color(0xFFFFDEC6);
  static const Color shadowColor = Color(0xFF62697B);
  static const Color ratingStartOutlineColor = Color(0x1AFFFFFF);
  static const Color bottomSheetDragColor = Color(0x6679747E);
  static const Color dropDownIconColor   = Color(0xFF6A7286);
  static const Color borderColorGrey   = Color(0xFF999999);
  static const Color colorGrey   = Color(0xFFD9D9D9);

  // static Color black900Af = fromHex('#af000000');

  static Color fromHex(String hexString) {
    final buffer = StringBuffer();
    if (hexString.length == 6 || hexString.length == 7) buffer.write('ff');
    buffer.write(hexString.replaceFirst('#', ''));
    return Color(int.parse(buffer.toString(), radix: 16));
  }
}
