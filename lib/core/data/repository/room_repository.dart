import 'package:cloud_firestore/cloud_firestore.dart';

import '../../domain/entity/room.dart';

class RoomRepository {
  final _collection = FirebaseFirestore.instance.collection('rooms');

  Future<List<Room>> getAllRooms() async {
    final docs = (await _collection.orderBy('number').get()).docs;

    final List<Room> rooms = [];

    for (var doc in docs) {
      rooms.add(Room.fromJson(doc.data()));
    }

    return rooms;
  }

}