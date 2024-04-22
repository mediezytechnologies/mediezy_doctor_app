part of 'generate_token_final_bloc.dart';

@immutable
abstract class GenerateTokenFinalEvent {}

class FetchGenerateTokenFinal extends GenerateTokenFinalEvent {
  final String startDate;
  final String endDate;
  final String startTime;
  final String endTime;
  final String timeDuration;
  final String scheduleType;
  final String clinicId;
  final List<String> selecteddays;

  FetchGenerateTokenFinal({
    required this.startDate,
    required this.endDate,
    required this.startTime,
    required this.endTime,
    required this.timeDuration,
    required this.scheduleType,
    required this.clinicId,
    required this.selecteddays,
  });
}
