part of 'get_current_token_bloc.dart';

@immutable
abstract class GetCurrentTokenEvent {}

class FetchGetCurrentToken extends GetCurrentTokenEvent {
  final String clinicId;
  final String scheduleType;

  FetchGetCurrentToken({required this.clinicId, required this.scheduleType});
}
