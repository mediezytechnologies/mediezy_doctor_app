part of 'get_all_late_bloc.dart';

@immutable
abstract class GetAllLateEvent {}

//get all late

class FetchAllLate extends GetAllLateEvent {
  final String clinicId;

  FetchAllLate({
    required this.clinicId,
  });
}

//get all early

class FetchAllEarly extends GetAllLateEvent {
  final String clinicId;

  FetchAllEarly({
    required this.clinicId,
  });
}

//get all break

class FetchAllBreak extends GetAllLateEvent {
  final String clinicId;

  FetchAllBreak({
    required this.clinicId,
  });
}


//delete Late

class DeleteLate extends GetAllLateEvent {
  final String scheduleId;

  DeleteLate({
    required this.scheduleId,
  });
}


//delete Late

class DeleteEarly extends GetAllLateEvent {
  final String scheduleId;

  DeleteEarly({
    required this.scheduleId,
  });
}

//delete break

class DeleteBreak extends GetAllLateEvent {
  final String reScheduleId;

  DeleteBreak({
    required this.reScheduleId,
  });
}
