class Room {
  final int number;
  final int capacity;
  final String type;
  final List<dynamic> equipment;
  final int price;

  Room({
    required this.number,
    required this.capacity,
    required this.type,
    required this.equipment,
    required this.price,
  });

  factory Room.fromJson(Map<String, dynamic> json) => Room(
    number: json['number'],
    capacity: json['capacity'],
    equipment: json['equipment'],
    type: json['type'],
    price: json['price'],
  );
}