import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import 'booking.dart';

class MyBookingBody extends StatelessWidget {
  const MyBookingBody({super.key});

  @override
  Widget build(BuildContext context) {

    return Padding(
      padding: EdgeInsets.symmetric(
        horizontal: 13.w,
      ),
      child: ListView.builder(
        itemCount: 10,
        itemBuilder: (context, index) {
          return const Booking();
        },
      )
    );
  }
}