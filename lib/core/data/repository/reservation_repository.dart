import 'package:cloud_firestore/cloud_firestore.dart';

import '../../domain/entity/reservation.dart';

class ReservationRepository {
  final _collection = FirebaseFirestore.instance.collection('reservations');

  Future<String> insertReservation(Map<String, dynamic> reservation) async {
    final newReservation = await _collection.add(reservation);
    return newReservation.id;
  }

  Future<List<Reservation>> getReservations() async {
    final docs = (await _collection.get()).docs;

    final List<Reservation> reservations = [];

    for (var doc in docs) {
      reservations.add(Reservation.fromJson(doc.data()));
    }

    return reservations;
  }
}