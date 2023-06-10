import 'package:flutter/material.dart';

import '../../../core/constants/app_color.dart';
import 'widgets/auth_body.dart';

class AuthScreen extends StatelessWidget {
  const AuthScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return const SafeArea(
      child: Scaffold(
        backgroundColor: AppColor.white1,
        body: AuthBody(),
      ),
    );
  }
}