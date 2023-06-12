part of 'reservation_bloc.dart';

abstract class ReservationEvent {}

class ReservationInsertEvent extends ReservationEvent {
  final Reservation reservation;

  ReservationInsertEvent(this.reservation);
}