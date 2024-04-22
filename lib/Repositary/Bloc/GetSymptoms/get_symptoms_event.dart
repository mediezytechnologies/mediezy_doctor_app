part of 'get_symptoms_bloc.dart';

@immutable
sealed class GetSymptomsEvent {}

class FetchSymptoms extends GetSymptomsEvent {}
