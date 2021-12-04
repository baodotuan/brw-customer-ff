import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

// ignore: avoid_classes_with_only_static_members
class FlutterFlowTheme {
  static const Color primaryColor = Color(0xFFFAC854);
  static const Color secondaryColor = Color(0xFF477DB8);
  static const Color tertiaryColor = Color(0xFFFFFFFF);

  static const Color grey1 = Color(0xFFF2F2F2);
  static const Color grey2 = Color(0xFFCECECE);
  static const Color black = Color(0xFF000000);
  static const Color stbBeige = Color(0xFFE9E6DF);
  static const Color bg01 = Color(0xFFEAE6D3);
  static const Color red01 = Color(0xFFB55329);

  String primaryFontFamily = 'Poppins';
  String secondaryFontFamily = 'Roboto';
  static TextStyle get title1 => GoogleFonts.getFont(
        'Roboto',
        color: Color(0xFF303030),
        fontWeight: FontWeight.w600,
        fontSize: 24,
      );
  static TextStyle get title2 => GoogleFonts.getFont(
        'Roboto',
        color: Color(0xFF303030),
        fontWeight: FontWeight.w500,
        fontSize: 22,
      );
  static TextStyle get title3 => GoogleFonts.getFont(
        'Roboto',
        color: Color(0xFF303030),
        fontWeight: FontWeight.w500,
        fontSize: 20,
      );
  static TextStyle get subtitle1 => GoogleFonts.getFont(
        'Roboto',
        color: Color(0xFF303030),
        fontWeight: FontWeight.w500,
        fontSize: 18,
      );
  static TextStyle get subtitle2 => GoogleFonts.getFont(
        'Roboto',
        color: Color(0xFF303030),
        fontWeight: FontWeight.normal,
        fontSize: 16,
      );
  static TextStyle get bodyText1 => GoogleFonts.getFont(
        'Roboto',
        color: Color(0xFF303030),
        fontWeight: FontWeight.normal,
        fontSize: 14,
      );
  static TextStyle get bodyText2 => GoogleFonts.getFont(
        'Roboto',
        color: Color(0xFF303030),
        fontWeight: FontWeight.normal,
        fontSize: 14,
      );
}

extension TextStyleHelper on TextStyle {
  TextStyle override({
    String fontFamily,
    Color color,
    double fontSize,
    FontWeight fontWeight,
    FontStyle fontStyle,
    bool useGoogleFonts = true,
  }) =>
      useGoogleFonts
          ? GoogleFonts.getFont(
              fontFamily,
              color: color ?? this.color,
              fontSize: fontSize ?? this.fontSize,
              fontWeight: fontWeight ?? this.fontWeight,
              fontStyle: fontStyle ?? this.fontStyle,
            )
          : copyWith(
              fontFamily: fontFamily,
              color: color,
              fontSize: fontSize,
              fontWeight: fontWeight,
              fontStyle: fontStyle,
            );
}
