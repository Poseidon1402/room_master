import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../../core/constants/app_color.dart';
import '../../../../core/domain/entity/reservation.dart';
import '../../../../core/presentation/components/app_elevated_button.dart';

class Booking extends StatelessWidget {
  final Reservation reservation;

  const Booking({
    super.key,
    required this.reservation,
  });

  @override
  Widget build(BuildContext context) {

    return Container(
      margin: EdgeInsets.symmetric(
        vertical: 5.h,
      ),
      constraints: BoxConstraints.expand(
        height: 150.h,
      ),
      padding: EdgeInsets.symmetric(
        horizontal: 17.w,
        vertical: 14.h,
      ),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(22.r),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          _buildBookingInfo(context),
          _buildDateAndHour(context),
        ],
      ),
    );
  }

  Widget _buildBookingInfo(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          'Salle #${reservation.room.number}',
          style: Theme.of(context).textTheme.bodyLarge,
        ),
        Text(
          '${reservation.room.capacity} places',
          style: Theme.of(context).textTheme.bodyMedium,
        ),
        Row(
          children: [
            AppElevatedButton(
              onPressed: () {},
              borderRadius: 51.r,
              width: 15,
              text: Text(
                'QR Code',
                style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                  color: Colors.white,
                ),
              ),
            ),
            SizedBox(width: 25.w,),
            TextButton(
              onPressed: () {},
              child: Text(
                'Annuler',
                style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                  color: AppColor.purple,
                ),
              ),
            ),
          ],
        )
      ],
    );
  }

  Widget _buildDateAndHour(BuildContext context) {
    final date = reservation.date.split(' ');

    return Column(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          date[0],
          style: Theme.of(context).textTheme.titleLarge?.copyWith(
            color: const Color.fromRGBO(250, 12, 55, 1),
            fontSize: 40.sp,
          ),
        ),
        Text(
          '${date[1]} ${date[2]}',
          style: Theme.of(context).textTheme.bodyLarge,
        ),
        Text(
          reservation.time,
          style: Theme.of(context).textTheme.bodyMedium,
        ),
      ],
    );
  }
}