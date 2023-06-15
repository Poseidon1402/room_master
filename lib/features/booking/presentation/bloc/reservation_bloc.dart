import 'dart:io';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

import '../../../../core/data/repository/reservation_repository.dart';
import '../../../../core/enums/load_status.dart';
import '../../../../core/domain/entity/reservation.dart';

part 'reservation_state.dart';
part 'reservation_event.dart';

class ReservationBloc extends Bloc<ReservationEvent, ReservationInsertionState> {
  final ReservationRepository _reservationRepository = ReservationRepository();

  ReservationBloc(): super(const ReservationInsertionState.initial()) {
    on<ReservationInsertEvent>(_mapReservationInsertEventToState);
  }

  void _mapReservationInsertEventToState(
    ReservationInsertEvent event, Emitter<ReservationInsertionState> emit
  ) async {

    try {
      emit(const ReservationInsertionState.loading());
      final id = await _reservationRepository.insertReservation(event.reservation.toJson());
      emit(ReservationInsertionState.success(id));
    } on SocketException {
      emit(const ReservationInsertionState.networkError());
    } catch (e) {
      emit(const ReservationInsertionState.error());
    }
  }
}