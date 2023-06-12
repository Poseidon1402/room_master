import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:meeting_room/core/enums/load_status.dart';

import '../bloc/room_bloc.dart';
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
        padding: EdgeInsets.only(
          left: 20.w,
          right: 20.w,
          top: 20.h,
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
                RoomCategoryFilterChip(
                  text: 'Salle de fête',
                  onSelected: (value) => print('test'),
                  isSelected: false,
                ),
              ],
            ),
            BlocBuilder<RoomBloc, RoomState>(builder: (context, state) {
              if (state.status.isLoading) {
                return const Expanded(
                  child: Center(
                    child: CircularProgressIndicator(),
                  ),
                );
              }

              return Expanded(
                child: ListView.builder(
                  itemCount: state.rooms?.length,
                  itemBuilder: (context, index) {
                    return Room(
                      room: state.rooms![index],
                    );
                  },
                ),
              );
            }),
          ],
        ),
      ),
    );
  }
}
