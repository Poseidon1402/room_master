import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:go_router/go_router.dart';

import '../../../../core/constants/app_color.dart';
import '../../../../core/constants/route_path.dart';

class Room extends StatelessWidget {

  @override
  Widget build(BuildContext context) {

    return Container(
      padding: EdgeInsets.symmetric(
        vertical: 14.h,
        horizontal: 10.w,
      ),
      margin: EdgeInsets.symmetric(
        vertical: 12.h,
      ),
      width: MediaQuery.of(context).size.width,
      height: 159.h,
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(22.r),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'Salle #1',
                style: Theme.of(context).textTheme.bodyLarge,
              ),
              Wrap(
                spacing: 12.w,
                children: [
                  Text(
                    '8 chaises',
                    style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                      color: Colors.black.withOpacity(0.5),
                    ),
                  ),
                  FaIcon(
                    FontAwesomeIcons.wifi,
                    size: 20.sp,
                    color: Colors.black.withOpacity(0.5),
                  ),
                  FaIcon(
                    FontAwesomeIcons.microphone,
                    size: 20.sp,
                    color: Colors.black.withOpacity(0.5),
                  ),
                ],
              ),
              const Spacer(),
              Wrap(
                spacing: 15.w,
                crossAxisAlignment: WrapCrossAlignment.center,
                children: [
                  OutlinedButton(
                    onPressed: () => context.push(RoutePath.book),
                    style: OutlinedButton.styleFrom(
                      side: const BorderSide(
                        color: AppColor.purple,
                      ),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(51.r),
                      ),
                    ),
                    child: Text(
                      'Reserver',
                      style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                        color: AppColor.purple,
                      ),
                    ),
                  ),
                  RichText(
                    text: TextSpan(
                      children: [
                        TextSpan(
                          text: '10.000Ar',
                          style: Theme.of(context).textTheme.bodySmall?.copyWith(
                            color: AppColor.purple,
                          ),
                        ),
                        TextSpan(
                          text: '/heure',
                          style: Theme.of(context).textTheme.bodySmall?.copyWith(
                            color: Colors.black.withOpacity(0.5),
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ],
          ),
          Container(
            width: 125.w,
            height: 131.h,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(22.r),
              image: const DecorationImage(
                image: AssetImage('assets/images/rooms.PNG'),
                fit: BoxFit.fill,
              ),
            ),
          ),
        ],
      ),
    );
  }
}