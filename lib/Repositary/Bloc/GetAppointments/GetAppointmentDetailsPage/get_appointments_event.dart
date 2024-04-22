part of 'get_appointments_bloc.dart';

@immutable
abstract class GetAppointmentsEvent {}


class FetchAppointmentDetailsPage extends GetAppointmentsEvent{
final String tokenId;

FetchAppointmentDetailsPage({
  required this.tokenId
});
}
