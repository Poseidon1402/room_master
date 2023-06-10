import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import 'room.dart';
import 'room_category_filter_chip.dart';

class RoomListBody extends StatelessWidget {
  const RoomListBody({super.key});

  @override
  Widget build(BuildContext context) {

    return SizedBox(
      width: MediaQuery.of(context).size.width,
      height: MediaQuery.of(context).size.height,
      child: Padding(
        padding: EdgeInsets.symmetric(
          horizontal: 20.w,
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Salles disponibles',
              style: Theme.of(context).textTheme.titleLarge?.copyWith(
                fontSize: 20.sp,
              ),
            ),
            Wrap(
              spacing: 10.w,
              children: [
                RoomCategoryFilterChip(
                  text: 'Tous',
                  onSelected: (value) => print('test'),
                  isSelected: true,
                ),
                RoomCategoryFilterChip(
                  text: 'Salle de réunion',
                  onSelected: (value) => print('test'),
                  isSelected: false,
                ),
              ],
            ),
            Expanded(
              child: ListView.builder(
                itemCount: 10,
                itemBuilder: (context, index) {
                  return Room();
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}