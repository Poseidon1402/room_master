import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';

class AppTheme {
  static final TextTheme textTheme = TextTheme(
    titleLarge:
    GoogleFonts.poppins(fontSize: 20.0.sp, fontWeight: FontWeight.w700),
    titleSmall:
    GoogleFonts.poppins(fontSize: 14.0.sp, fontWeight: FontWeight.w600),
    bodyLarge:
    GoogleFonts.poppins(fontSize: 16.0.sp, fontWeight: FontWeight.w700),
    bodyMedium:
    GoogleFonts.poppins(fontSize: 15.0.sp, fontWeight: FontWeight.w400),
    bodySmall:
    GoogleFonts.poppins(fontSize: 14.0.sp, fontWeight: FontWeight.w400),
  );

  static ThemeData customTheme() {

    return ThemeData(
      brightness: Brightness.light,
      textTheme: textTheme,
    );
  }
}