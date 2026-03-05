import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class AppTheme {
  static const primaryGold = Color(0xFFD4AF37);
  
  static ThemeData darkTheme = ThemeData(
    brightness: Brightness.dark,
    scaffoldBackgroundColor: Colors.black,
    primaryColor: primaryGold,
    textTheme: GoogleFonts.cairoTextTheme(ThemeData.dark().textTheme),
  );

  static ThemeData lightTheme = ThemeData(
    brightness: Brightness.light,
    scaffoldBackgroundColor: Colors.white,
    primaryColor: primaryGold,
    textTheme: GoogleFonts.cairoTextTheme(ThemeData.light().textTheme),
  );
}
