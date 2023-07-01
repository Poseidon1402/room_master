import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

import '../../domain/entity/reservation.dart';

class ReservationRepository {
  final _collection = FirebaseFirestore.instance.collection('reservations');

  Future<String> insertReservation(Map<String, dynamic> reservation) async {
    final newReservation = await _collection.add(reservation);
    return newReservation.id;
  }

  Future<List<Reservation>> getReservations() async {
    final docs = (await _collection
            .where('user', isEqualTo: FirebaseAuth.instance.currentUser?.email)
            .get())
        .docs;

    final List<Reservation> reservations = [];

    for (var doc in docs) {
      reservations.add(Reservation.fromJson(doc.id, doc.data()));
    }

    return reservations;
  }
}
