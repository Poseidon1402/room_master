import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../../core/constants/app_color.dart';

class IconBottomBar extends StatelessWidget {
  final IconData icon;
  final bool selected;
  final Function()? onPressed;

  const IconBottomBar({
    super.key,
    required this.icon,
    this.onPressed,
    required this.selected,
  });

  @override
  Widget build(BuildContext context) {

    return Column(
      children: [
        InkWell(
          onTap: onPressed,
          child: SizedBox(
            width: 46.w,
            height: 46.w,
            child: Icon(
              icon,
              size: 30.r,
              color: selected ? AppColor.purple : Colors.black.withOpacity(0.5),
            ),
          ),
        ),
        if(selected) SizedBox(height: 5.h,),
        if(selected) Container(
          width: 10.w,
          height: 10.h,
          decoration: const BoxDecoration(
            color: AppColor.purple,
            shape: BoxShape.circle,
          ),
        ),
      ],
    );
  }
}