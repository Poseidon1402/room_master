import 'room.dart';

class Reservation {
  final Room room;
  final String user;
  final DateTime date;
  final String time;

  Reservation({
    required this.room,
    required this.date,
    required this.user,
    required this.time,
  });

  factory Reservation.fromJson(Map<String, dynamic> json) => Reservation(
        room: Room.fromJson(json['room']),
        date: json['date'],
        user: json['user'],
        time: json['time'],
      );

  Map<String, dynamic> toJson() => {
        'room': room,
        'date': date,
        'user': user,
        'time': time,
      };
}
