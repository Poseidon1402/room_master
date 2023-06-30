import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../../core/data/repository/reservation_repository.dart';
import 'booking.dart';

class MyBookingBody extends StatelessWidget {
  const MyBookingBody({super.key});

  @override
  Widget build(BuildContext context) {

    return Padding(
      padding: EdgeInsets.symmetric(
        horizontal: 13.w,
      ),
      child: FutureBuilder(
        future: ReservationRepository().getReservations(),
        builder: (context, snapshot) {
          if(snapshot.connectionState == ConnectionState.done) {
            final reservations = snapshot.data;

            if(reservations!.isEmpty) {
              return Center(
                child: Text(
                  'Aucune reservation trouvée',
                  style: Theme.of(context).textTheme.titleLarge,
                ),
              );
            }

            return ListView.builder(
              itemCount: reservations.length,
              itemBuilder: (context, index) {
                return Booking(reservation: reservations[index],);
              },
            );
          }

          return const Center(
            child: CircularProgressIndicator(),
          );
        }
      )
    );
  }
}