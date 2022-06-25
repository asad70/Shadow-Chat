// ignore_for_file: overridden_fields, annotate_overrides

import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

abstract class AppTheme {
  static AppTheme of(BuildContext context) => LightModeTheme();

  Color primaryColor;
  Color secondaryColor;
  Color tertiaryColor;
  Color alternate;
  Color primaryBackground;
  Color secondaryBackground;
  Color primaryText;
  Color secondaryText;

  Color grayDark;
  Color dark900;
  Color background;
  Color grayIcon;
  Color tertiary;
  Color primaryBtnText;
  Color lineColor;

  TextStyle get title1 => GoogleFonts.getFont(
        'Mukta',
        color: primaryBtnText,
        fontWeight: FontWeight.w500,
        fontSize: 34,
      );
  TextStyle get title2 => GoogleFonts.getFont(
        'Mukta',
        color: primaryText,
        fontWeight: FontWeight.w300,
        fontSize: 28,
      );
  TextStyle get title3 => GoogleFonts.getFont(
        'Mukta',
        color: primaryText,
        fontWeight: FontWeight.w500,
        fontSize: 20,
      );
  TextStyle get subtitle1 => GoogleFonts.getFont(
        'Mukta',
        color: primaryText,
        fontWeight: FontWeight.w500,
        fontSize: 18,
      );
  TextStyle get subtitle2 => GoogleFonts.getFont(
        'Mukta',
        color: primaryText,
        fontWeight: FontWeight.normal,
        fontSize: 16,
      );
  TextStyle get bodyText1 => GoogleFonts.getFont(
        'Mukta',
        color: primaryText,
        fontWeight: FontWeight.normal,
        fontSize: 14,
      );
  TextStyle get bodyText2 => GoogleFonts.getFont(
        'Mukta',
        color: secondaryText,
        fontWeight: FontWeight.normal,
        fontSize: 14,
      );
}

class LightModeTheme extends AppTheme {
  Color primaryColor = const Color(0xFF341C1C);
  Color secondaryColor = const Color(0xFF39D2C0);
  Color tertiaryColor = const Color(0xFF1D2429);
  Color alternate = const Color(0xDB1D2429);
  Color primaryBackground = const Color(0xFFEFF7F5);
  Color secondaryBackground = const Color(0xFFFFFFFF);
  Color primaryText = const Color(0xFF101213);
  Color secondaryText = const Color(0xFF57636C);

  Color grayDark = Color(0xFF616E78);
  Color dark900 = Color(0xFFFFFFFF);
  Color background = Color(0xFF516270);
  Color grayIcon = Color(0xFF95A1AC);
  Color tertiary = Color(0xFF39D2C0);
  Color primaryBtnText = Color(0xFFFFFFFF);
  Color lineColor = Color(0xFFE0E3E7);
}

extension TextStyleHelper on TextStyle {
  TextStyle override({
    String fontFamily,
    Color color,
    double fontSize,
    FontWeight fontWeight,
    FontStyle fontStyle,
    bool useGoogleFonts = true,
    TextDecoration decoration,
    double lineHeight,
  }) =>
      useGoogleFonts
          ? GoogleFonts.getFont(
              fontFamily,
              color: color ?? this.color,
              fontSize: fontSize ?? this.fontSize,
              fontWeight: fontWeight ?? this.fontWeight,
              fontStyle: fontStyle ?? this.fontStyle,
              decoration: decoration,
              height: lineHeight,
            )
          : copyWith(
              fontFamily: fontFamily,
              color: color,
              fontSize: fontSize,
              fontWeight: fontWeight,
              fontStyle: fontStyle,
              decoration: decoration,
              height: lineHeight,
            );
}
