import 'package:flutter/material.dart';

import '../../../core/constants/app_color.dart';
import 'widgets/subscribe_body.dart';

class SubscribeScreen extends StatelessWidget {
  const SubscribeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return const SafeArea(
      child: Scaffold(
        backgroundColor: AppColor.white1,
        body: SubscribeBody(),
      ),
    );
  }
}