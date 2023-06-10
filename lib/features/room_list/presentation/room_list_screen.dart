import 'package:flutter/material.dart';

import '../../../core/constants/app_color.dart';
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
        body: const RoomListBody(),
      ),
    );
  }
}