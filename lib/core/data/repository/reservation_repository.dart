import 'package:cloud_firestore/cloud_firestore.dart';

class ReservationRepository {
  final _collection = FirebaseFirestore.instance.collection('reservations');

  Future<String> insertReservation(Map<String, dynamic> reservation) async {
    final newReservation = await _collection.add(reservation);
    return newReservation.id;
  }

}