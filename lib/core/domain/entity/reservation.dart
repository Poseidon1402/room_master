import 'room.dart';

class Reservation {
  final String? id;
  final Room room;
  final String user;
  final String date;
  final String time;

  Reservation({
    this.id,
    required this.room,
    required this.date,
    required this.user,
    required this.time,
  });

  factory Reservation.fromJson(String id, Map<String, dynamic> json) =>
      Reservation(
        id: id,
        room: Room.fromJson(json['room']),
        date: json['date'],
        user: json['user'],
        time: json['time'],
      );

  Map<String, dynamic> toJson() => {
        'room': room.toJson(),
        'date': date,
        'user': user,
        'time': time,
      };
}
