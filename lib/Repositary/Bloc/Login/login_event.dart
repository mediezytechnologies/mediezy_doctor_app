part of 'login_bloc.dart';

@immutable
abstract class LoginEvent {}

class FetchLogin extends LoginEvent {
  final String email;
  final String password;

  FetchLogin({required this.email, required this.password});
}

//signup

class FetchSignup extends LoginEvent {
  final String email;
  final String password;
  final String firstname;
  final String secondname;
  final String mobileNo;

  FetchSignup({
    required this.email,
    required this.password,
    required this.firstname,
    required this.secondname,
    required this.mobileNo,
  });
}

//Dummy register

// class DummyRegister extends LoginEvent {
//   final String email;
//   final String firstname;
//   final String dob;
//   final String mobileNo;
//   final String location;
//   final String hospitalName;
//   final String specialization;
//   // final String doctorImage;

//   DummyRegister({
//     required this.email,
//     required this.firstname,
//     required this.dob,
//     required this.mobileNo,
//     required this.location,
//     required this.hospitalName,
//     required this.specialization,
//     // required this.doctorImage,
//   });
// }

//!guest register

class GuestRegister extends LoginEvent {
  final String email;
  final String name;
  final String mobileNo;

  GuestRegister({
    required this.email,
    required this.name,
    required this.mobileNo,
  });
}
