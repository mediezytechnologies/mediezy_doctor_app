part of 'bottom_sheet_bloc.dart';

@immutable
sealed class BottomSheetState {}

final class BottomSheetInitial extends BottomSheetState {}

final class BottomSheetLoading extends BottomSheetState {}

final class BottomSheetLoaded extends BottomSheetState {
  final BottomsheetModel bottomSheetModel;

  BottomSheetLoaded({required this.bottomSheetModel});
}

final class BottomSheetError extends BottomSheetState {}
