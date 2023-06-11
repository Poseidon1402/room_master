part of 'room_bloc.dart';

class RoomState {
  final LoadStatus status;
  final List<Room>? rooms;

  RoomState({
    required this.status,
    this.rooms,
  });

  factory RoomState.initial() => RoomState(status: LoadStatus.initial);

  factory RoomState.loading() => RoomState(status: LoadStatus.loading);

  factory RoomState.success(List<Room> rooms) => RoomState(
    status: LoadStatus.success,
    rooms: rooms
  );

  factory RoomState.error() => RoomState(status: LoadStatus.error);

  factory RoomState.networkError() => RoomState(status: LoadStatus.networkError);
}