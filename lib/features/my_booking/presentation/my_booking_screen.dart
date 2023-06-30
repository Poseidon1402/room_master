import 'package:flutter/material.dart';

import '../../../core/constants/app_color.dart';
import 'widgets/my_booking_body.dart';

class MyBookingScreen extends StatelessWidget {
  const MyBookingScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Mes Réservations',
          style: Theme.of(context).textTheme.titleLarge,
        ),
        elevation: 0.0,
        backgroundColor: Colors.transparent,
        centerTitle: false,
      ),
      backgroundColor: AppColor.white1,
      body: const MyBookingBody(),
    );
  }
}