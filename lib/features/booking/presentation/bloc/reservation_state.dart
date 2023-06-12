part of 'reservation_bloc.dart';

class ReservationInsertionState extends Equatable {
  final LoadStatus status;

  const ReservationInsertionState({
    required this.status,
  });

  const ReservationInsertionState.initial() : this(status: LoadStatus.initial);

  const ReservationInsertionState.loading() : this(status: LoadStatus.loading);

  const ReservationInsertionState.success() : this(status: LoadStatus.success,);

  const ReservationInsertionState.error() : this(status: LoadStatus.error);

  const ReservationInsertionState.networkError() : this(status: LoadStatus.networkError);

  @override
  List<Object?> get props => [status];
}