import 'package:bloc/bloc.dart';

import '../../../../core/data/repository/reservation_repository.dart';
import '../../../../core/enums/load_status.dart';
import '../../../../core/domain/entity/reservation.dart';

part 'reservation_state.dart';
part 'reservation_event.dart';

class ReservationBloc extends Bloc<ReservationEvent, ReservationInsertionState> {
  final ReservationRepository _reservationRepository = ReservationRepository();

  ReservationBloc(): super(ReservationInsertionState.initial()) {
    on<ReservationInsertEvent>(_mapReservationInsertEventToState);
  }

  void _mapReservationInsertEventToState(
    ReservationInsertEvent event, Emitter<ReservationInsertionState> emit
  ) async {
    emit(ReservationInsertionState.loading());
    try {
      _reservationRepository.insertReservation(event.reservation.toJson());
      emit(ReservationInsertionState.success());
    } catch (e) {
      emit(ReservationInsertionState.error());
    }
  }
}