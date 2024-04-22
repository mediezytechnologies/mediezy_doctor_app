part of 'get_clinic_bloc.dart';

@immutable
abstract class GetClinicState {
}

class GetClinicInitial extends GetClinicState {
}

class GetClinicLoading extends GetClinicState {
  // const GetClinicLoading(super.changValue);
}

class GetClinicLoaded extends GetClinicState {
  // const GetClinicLoaded(super.changValue);
}

class GetClinicError extends GetClinicState {
  // const GetClinicError(super.changValue);
}



// class GetClinicValue extends GetClinicState {
//   final String changValue;
//
//   GetClinicValue(this.changValue);
// }
