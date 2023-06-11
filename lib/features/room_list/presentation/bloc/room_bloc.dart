import 'dart:io';

import 'package:bloc/bloc.dart';

import '../../../../core/data/repository/room_repository.dart';
import '../../../../core/domain/entity/room.dart';
import '../../../../core/enums/load_status.dart';

part 'room_state.dart';
part 'room_event.dart';

class RoomBloc extends Bloc<RoomEvent, RoomState> {
  final RoomRepository _repository = RoomRepository();

  RoomBloc(): super(RoomState.initial()) {
   on<RoomFetchingEvent>(_mapRoomFetchingEventToState);
  }

  void _mapRoomFetchingEventToState(
      RoomFetchingEvent event, Emitter<RoomState> emit
      ) async {

    try {
      emit(RoomState.loading());
      final rooms = await _repository.getAllRooms();
      emit(RoomState.success(rooms));
    } on SocketException {
      emit(RoomState.networkError());
    } catch (e) {
      emit(RoomState.error());
    }
  }
}