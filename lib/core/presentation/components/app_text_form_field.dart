import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class AppTextFormField extends StatelessWidget {
  final TextEditingController? controller;
  final String? hintText;
  final String suffixText;
  final TextInputType? type;
  final bool obscureText;
  final Widget? prefixIcon;
  final Widget? suffixIcon;
  final bool showCursor;
  final bool readOnly;
  final Function()? onTap;

  const AppTextFormField({
    super.key,
    this.controller,
    this.hintText,
    this.suffixText = '',
    this.prefixIcon,
    this.suffixIcon,
    this.onTap,
    this.type,
    this.obscureText = false,
    this.showCursor = true,
    this.readOnly = false,
  });
  
  @override
  Widget build(BuildContext context) {
    
    return TextFormField(
      controller: controller,
      onTap: onTap,
      obscureText: obscureText,
      keyboardType: type,
      showCursor: showCursor,
      readOnly: readOnly,
      decoration: InputDecoration(
        contentPadding: EdgeInsets.symmetric(
          horizontal: 10.w,
        ),
        hintText: hintText,
        hintStyle: Theme.of(context).textTheme.bodySmall?.copyWith(
          color: Colors.black.withOpacity(0.4),
        ),
        suffixText: suffixText,
        suffixStyle: Theme.of(context).textTheme.bodySmall,
        prefixIcon: prefixIcon,
        filled: true,
        fillColor: Colors.white,
        border: OutlineInputBorder(
          borderSide: BorderSide.none,
          borderRadius: BorderRadius.circular(12.r),
        ),
        suffixIcon: suffixIcon,
      ),
    );
  }
}