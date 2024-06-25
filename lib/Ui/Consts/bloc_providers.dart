import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mediezy_doctor/Repositary/Bloc/BookAppointment/book_appointment_bloc.dart';
import 'package:mediezy_doctor/Repositary/Bloc/ContactUs/contact_us_bloc.dart';
import 'package:mediezy_doctor/Repositary/Bloc/CustomSchedule/BetweenCustomSchedule/between_schedule_bloc.dart';
import 'package:mediezy_doctor/Repositary/Bloc/CustomSchedule/GetAllLate/get_all_late_bloc.dart';
import 'package:mediezy_doctor/Repositary/Bloc/CustomSchedule/LateCustomSchedule/late_schedule_bloc.dart';
import 'package:mediezy_doctor/Repositary/Bloc/DeleteTokens/delete_tokens_bloc.dart';
import 'package:mediezy_doctor/Repositary/Bloc/GenerateToken/GenerateTokenFinal/generate_token_final_bloc.dart';
import 'package:mediezy_doctor/Repositary/Bloc/GenerateToken/GetClinic/get_clinic_bloc.dart';
import 'package:mediezy_doctor/Repositary/Bloc/GenerateToken/generated_schedules/generated_schedules_bloc.dart';
import 'package:mediezy_doctor/Repositary/Bloc/GenerateToken/selected_clinic/selected_clinic_bloc.dart';
import 'package:mediezy_doctor/Repositary/Bloc/GetAppointments/AddAllAppointmentDetails/add_all_appointment_details_bloc.dart';
import 'package:mediezy_doctor/Repositary/Bloc/GetAppointments/AddPrescription/add_prescription_bloc.dart';
import 'package:mediezy_doctor/Repositary/Bloc/GetAppointments/AddVitals/add_vitals_bloc.dart';
import 'package:mediezy_doctor/Repositary/Bloc/GetAppointments/DeleteMedicine/delete_medicine_bloc.dart';
import 'package:mediezy_doctor/Repositary/Bloc/GetAppointments/EditMedicine/edit_medicine_bloc.dart';
import 'package:mediezy_doctor/Repositary/Bloc/GetAppointments/GetAllCompletedAppointments/ge_all_completed_appointments_bloc.dart';
import 'package:mediezy_doctor/Repositary/Bloc/GetAppointments/GetAllPreviousAppointments/get_all_previous_appointments_bloc.dart';
import 'package:mediezy_doctor/Repositary/Bloc/GetAppointments/GetAllPreviousAppointments/previous_details/previous_details_bloc.dart';
import 'package:mediezy_doctor/Repositary/Bloc/GetAppointments/get_all_medicines/get_all_medicines_bloc.dart';
import 'package:mediezy_doctor/Repositary/Bloc/GetAppointments/get_all_medicines/update_favourite_medicine/bloc/update_favourite_medicine_bloc.dart';
import 'package:mediezy_doctor/Repositary/Bloc/GetSymptoms/get_symptoms_bloc.dart';
import 'package:mediezy_doctor/Repositary/Bloc/GetToken/get_token_bloc.dart';
import 'package:mediezy_doctor/Repositary/Bloc/HealthRecords/AllHealthRecords/all_health_records_bloc.dart';
import 'package:mediezy_doctor/Repositary/Bloc/HealthRecords/DischargeSummary/discharge_summary_bloc.dart';
import 'package:mediezy_doctor/Repositary/Bloc/HealthRecords/GetPrescription/get_prescription_bloc.dart';
import 'package:mediezy_doctor/Repositary/Bloc/HealthRecords/GetPrescriptionView/get_prescription_view_bloc.dart';
import 'package:mediezy_doctor/Repositary/Bloc/HealthRecords/LabReport/lab_report_bloc.dart';
import 'package:mediezy_doctor/Repositary/Bloc/HealthRecords/ScanReport/scan_report_bloc.dart';
import 'package:mediezy_doctor/Repositary/Bloc/HealthRecords/TimeLine/time_line_bloc.dart';
import 'package:mediezy_doctor/Repositary/Bloc/HealthRecords/completedAppointmentsHR/completed_appointments_health_record_bloc.dart';
import 'package:mediezy_doctor/Repositary/Bloc/HealthRecords/get_all_vitals/get_all_vitals_bloc.dart';
import 'package:mediezy_doctor/Repositary/Bloc/Labs/AddFavouritesLab/add_favourites_lab_bloc.dart';
import 'package:mediezy_doctor/Repositary/Bloc/Labs/GetAllFavouriteLab/get_all_favourite_lab_bloc.dart';
import 'package:mediezy_doctor/Repositary/Bloc/Labs/GetAllLab/get_all_lab_bloc.dart';
import 'package:mediezy_doctor/Repositary/Bloc/Labs/GetAllScanningCentre/get_all_scanning_centre_bloc.dart';
import 'package:mediezy_doctor/Repositary/Bloc/Labs/RemoveFavLab/remove_fav_labs_bloc.dart';
import 'package:mediezy_doctor/Repositary/Bloc/Labs/SearchLab/search_lab_bloc.dart';
import 'package:mediezy_doctor/Repositary/Bloc/Labs/SearchScanningCentre/search_scanning_centre_bloc.dart';
import 'package:mediezy_doctor/Repositary/Bloc/LeaveUpdate/GetAllLeaves/get_all_leaves_bloc.dart';
import 'package:mediezy_doctor/Repositary/Bloc/LeaveUpdate/LeaveUpdate/leave_update_bloc.dart';
import 'package:mediezy_doctor/Repositary/Bloc/LeaveUpdate/leave_check/leave_check_bloc.dart';
import 'package:mediezy_doctor/Repositary/Bloc/LiveToken/AddCheckinOrCheckout/add_checkin_or_checkout_bloc.dart';
import 'package:mediezy_doctor/Repositary/Bloc/LiveToken/GetCurrentToken/get_current_token_bloc.dart';
import 'package:mediezy_doctor/Repositary/Bloc/Login/login_bloc.dart';
import 'package:mediezy_doctor/Repositary/Bloc/MedicalShoppe/AddMedicalShope/add_medical_shope_bloc.dart';
import 'package:mediezy_doctor/Repositary/Bloc/MedicalShoppe/GetAllFavouriteMedicalStore/get_all_favourite_medical_store_bloc.dart';
import 'package:mediezy_doctor/Repositary/Bloc/MedicalShoppe/GetAllMedicalShoppe/get_all_medical_shoppe_bloc.dart';
import 'package:mediezy_doctor/Repositary/Bloc/MedicalShoppe/RemoveMedicalShope/remove_medical_shope_bloc.dart';
import 'package:mediezy_doctor/Repositary/Bloc/MedicalShoppe/SearchMedicalStore/search_medical_store_bloc.dart';
import 'package:mediezy_doctor/Repositary/Bloc/Profile/ProfileEdit/profile_edit_bloc.dart';
import 'package:mediezy_doctor/Repositary/Bloc/Profile/ProfileGet/profile_get_bloc.dart';
import 'package:mediezy_doctor/Repositary/Bloc/ReserveToken/reserve_token_bloc.dart';
import 'package:mediezy_doctor/Repositary/Bloc/RestoreTokens/DeletedTokens/deleted_tokens_bloc.dart';
import 'package:mediezy_doctor/Repositary/Bloc/RestoreTokens/restore_tokens_bloc.dart';
import 'package:mediezy_doctor/Repositary/Bloc/Suggestions/suggestion_bloc.dart';
import 'package:mediezy_doctor/Repositary/Bloc/bottomsheet/bloc/bottom_sheet_bloc.dart';
import 'package:mediezy_doctor/Repositary/Bloc/patients/PatientsGet/patients_get_bloc.dart';
import 'package:mediezy_doctor/Repositary/Bloc/patients/search_patients/search_patients_bloc.dart';
import 'package:mediezy_doctor/Repositary/Bloc/suggest_doctor/suggest_doctor_bloc.dart';

import '../../Repositary/Bloc/GetAppointments/search_lab_test/favourite_lab_test/favourite_lab_test_bloc.dart';
import '../../Repositary/Bloc/GetAppointments/search_lab_test/search_lab/search_lab_test_bloc.dart';

class AppBBlocProviders {
  static get allBlocProviders => [
        BlocProvider(create: (context) => LoginBloc()),
        BlocProvider(create: (context) => GetClinicBloc()),
        BlocProvider(create: (context) => GenerateTokenFinalBloc()),
        BlocProvider(create: (context) => ProfileGetBloc()),
        BlocProvider(create: (context) => ProfileEditBloc()),
        BlocProvider(create: (context) => GetTokenBloc()),
        BlocProvider(create: (context) => BookAppointmentBloc()),
        BlocProvider(create: (context) => GetSymptomsBloc()),
        BlocProvider(create: (context) => AddPrescriptionBloc()),
        BlocProvider(create: (context) => GetAllCompletedAppointmentsBloc()),
        BlocProvider(create: (context) => LateScheduleBloc()),
        BlocProvider(create: (context) => BetweenScheduleBloc()),
        BlocProvider(create: (context) => LeaveUpdateBloc()),
        BlocProvider(create: (context) => GetAllLeavesBloc()),
        BlocProvider(create: (context) => DeleteTokensBloc()),
        BlocProvider(create: (context) => GetCurrentTokenBloc()),
        BlocProvider(create: (context) => GetAllLabBloc()),
        BlocProvider(create: (context) => GetAllScanningCentreBloc()),
        BlocProvider(create: (context) => AddFavouritesLabBloc()),
        BlocProvider(create: (context) => GetAllFavouriteLabBloc()),
        BlocProvider(create: (context) => RemoveFavLabsBloc()),
        BlocProvider(create: (context) => GetAllMedicalShoppeBloc()),
        BlocProvider(create: (context) => RemoveMedicalShopeBloc()),
        BlocProvider(create: (context) => AddMedicalShopeBloc()),
        BlocProvider(create: (context) => AllHealthRecordsBloc()),
        BlocProvider(create: (context) => GetPrescriptionBloc()),
        BlocProvider(create: (context) => LabReportBloc()),
        BlocProvider(create: (context) => TimeLineBloc()),
        BlocProvider(create: (context) => GetPrescriptionViewBloc()),
        BlocProvider(create: (context) => GetAllFavouriteMedicalStoreBloc()),
        BlocProvider(create: (context) => PatientsGetBloc()),
        BlocProvider(create: (context) => AddCheckinOrCheckoutBloc()),
        BlocProvider(create: (context) => DeleteMedicineBloc()),
        BlocProvider(create: (context) => EditMedicineBloc()),
        BlocProvider(create: (context) => SearchLabBloc()),
        BlocProvider(create: (context) => SearchScanningCentreBloc()),
        BlocProvider(create: (context) => SearchMedicalStoreBloc()),
        BlocProvider(create: (context) => AddAllAppointmentDetailsBloc()),
        BlocProvider(create: (context) => GetAllPreviousAppointmentsBloc()),
        BlocProvider(create: (context) => SuggestionBloc()),
        BlocProvider(create: (context) => GetAllLateBloc()),
        BlocProvider(create: (context) => ReserveTokenBloc()),
        BlocProvider(create: (context) => AddVitalsBloc()),
        BlocProvider(create: (context) => RestoreTokensBloc()),
        BlocProvider(create: (context) => DeletedTokensBloc()),
        BlocProvider(
            create: (context) => CompletedAppointmentsHealthRecordBloc()),
        BlocProvider(create: (context) => SuggestDoctorBloc()),
        BlocProvider(create: (context) => ScanReportBloc()),
        BlocProvider(create: (context) => DischargeSummaryBloc()),
        BlocProvider(create: (context) => ContactUsBloc()),
        BlocProvider(create: (context) => SelectedClinicBloc()),
        BlocProvider(create: (context) => LeaveCheckBloc()),
        BlocProvider(create: (context) => GetAllVitalsBloc()),
        BlocProvider(create: (context) => PreviousDetailsBloc()),
        BlocProvider(create: (context) => SearchPatientsBloc()),
        BlocProvider(create: (context) => GetAllMedicinesBloc()),
        BlocProvider(create: (context) => UpdateFavouriteMedicineBloc()),
        BlocProvider(create: (context) => BottomSheetBloc()),
        BlocProvider(create: (context) => SearchLabTestBloc()),
        BlocProvider(create: (context) => FavouriteLabTestBloc()),
        BlocProvider(create: (context) => GeneratedSchedulesBloc()),
      ];
}
