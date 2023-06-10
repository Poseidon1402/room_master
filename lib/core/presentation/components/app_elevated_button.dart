import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../constants/app_color.dart';

class AppElevatedButton extends StatelessWidget {
  final Function()? onPressed;
  final String text;
  final Color buttonColor;
  final double fontSize;
  final Color fontColor;
  final double borderRadius;
  final double width;
  final double height;

  const AppElevatedButton({
    super.key,
    this.onPressed,
    this.buttonColor = AppColor.purple,
    this.text = '',
    this.fontSize = 16,
    this.fontColor = Colors.white,
    this.borderRadius = 12,
    this.width = double.maxFinite,
    this.height = 58,
  });

  @override
  Widget build(BuildContext context) {

    return ElevatedButton(
      onPressed: onPressed,
      style: ElevatedButton.styleFrom(
        backgroundColor: buttonColor,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(borderRadius.r),
        ),
        minimumSize: Size(width.w, height.h),
      ),
      child: Text(
        text,
        style: Theme.of(context).textTheme.bodyLarge?.copyWith(
          color: fontColor,
          fontSize: fontSize,
        ),
      ),
    );
  }
}