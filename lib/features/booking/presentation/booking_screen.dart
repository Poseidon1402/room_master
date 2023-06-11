import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import '../../../core/constants/app_color.dart';
import 'widgets/booking_body.dart';

class BookingScreen extends StatelessWidget {
  const BookingScreen({super.key});

  @override
  Widget build(BuildContext context) {

    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          leading: IconButton(
            onPressed: () => context.pop(),
            icon: Icon(Icons.arrow_back_ios,
              color: Colors.black.withOpacity(0.4),
            ),
          ),
          title: RichText(
            text: TextSpan(
              children: [
                TextSpan(
                  text: 'Réservation\n',
                  style: Theme.of(context).textTheme.bodyLarge,
                ),
                TextSpan(
                  text: 'Salle #1',
                  style: Theme.of(context).textTheme.bodySmall,
                ),
              ],
            ),
          ),
          elevation: 0.0,
          backgroundColor: AppColor.white1,
        ),
        backgroundColor: AppColor.white1,
        body: const BookingBody(),
      ),
    );
  }
}