import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

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
          backgroundColor: AppColor.purple,
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