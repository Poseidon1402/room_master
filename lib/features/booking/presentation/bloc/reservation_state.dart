part of 'reservation_bloc.dart';

class ReservationInsertionState {
  final LoadStatus status;

  ReservationInsertionState({
    required this.status,
  });

  factory ReservationInsertionState.initial() => ReservationInsertionState(status: LoadStatus.initial);

  factory ReservationInsertionState.loading() => ReservationInsertionState(status: LoadStatus.loading);

  factory ReservationInsertionState.success() => ReservationInsertionState(
      status: LoadStatus.success,
  );

  factory ReservationInsertionState.error() => ReservationInsertionState(status: LoadStatus.error);

  factory ReservationInsertionState.networkError() => ReservationInsertionState(status: LoadStatus.networkError);
}