import 'package:cloud_firestore/cloud_firestore.dart';

class ReservationRepository {
  final _collection = FirebaseFirestore.instance.collection('reservations');

  void insertReservation(Map<String, dynamic> reservation) async {
    await _collection.add(reservation);
  }

}