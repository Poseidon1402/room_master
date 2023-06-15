part of 'reservation_bloc.dart';

class ReservationInsertionState extends Equatable {
  final LoadStatus status;
  final String? reservationId;

  const ReservationInsertionState({
    required this.status,
    this.reservationId,
  });

  const ReservationInsertionState.initial() : this(status: LoadStatus.initial);

  const ReservationInsertionState.loading() : this(status: LoadStatus.loading);

  const ReservationInsertionState.success(String reservationId)
      : this(
          status: LoadStatus.success,
          reservationId: reservationId,
        );

  const ReservationInsertionState.error() : this(status: LoadStatus.error);

  const ReservationInsertionState.networkError()
      : this(status: LoadStatus.networkError);

  @override
  List<Object?> get props => [status];
}
