import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';

import '../../../core/constants/app_color.dart';
import '../../../core/domain/entity/room.dart';
import 'bloc/reservation_bloc.dart';
import 'widgets/booking_body.dart';

class BookingScreen extends StatelessWidget {
  final Room room;

  const BookingScreen({
    super.key,
    required this.room,
  });

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
                  text: 'Salle #${room.number}',
                  style: Theme.of(context).textTheme.bodySmall,
                ),
              ],
            ),
          ),
          elevation: 0.0,
          backgroundColor: AppColor.white1,
        ),
        backgroundColor: AppColor.white1,
        body: BlocProvider(
          create: (context) => ReservationBloc(),
          child: BookingBody(room: room),
        ),
      ),
    );
  }
}