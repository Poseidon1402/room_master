import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../core/constants/app_color.dart';
import 'bloc/room_bloc.dart';
import 'widgets/room_list_body.dart';

class RoomListScreen extends StatelessWidget {
  const RoomListScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          elevation: 0.0,
          backgroundColor: Colors.transparent,
          title: Padding(
            padding: EdgeInsets.symmetric(
              vertical: 12.h,
            ),
            child: RichText(
              text: TextSpan(
                children: [
                  TextSpan(
                    text: 'Bonjour Aina\n',
                    style: Theme.of(context).textTheme.titleLarge?.copyWith(
                          fontSize: 20.sp,
                        ),
                  ),
                  TextSpan(
                    text: 'Bienvenue sur e-room\n',
                    style: Theme.of(context).textTheme.bodySmall?.copyWith(
                          color: Colors.black.withOpacity(0.4),
                        ),
                  ),
                ],
              ),
            ),
          ),
        ),
        backgroundColor: AppColor.white1,
        body: BlocProvider(
          create: (context) => RoomBloc()..add(RoomFetchingEvent()),
          child: const RoomListBody(),
        ),
      ),
    );
  }
}
