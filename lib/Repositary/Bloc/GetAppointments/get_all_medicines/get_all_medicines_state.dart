part of 'get_all_medicines_bloc.dart';

@immutable
abstract class GetAllMedicinesState {}

class GetAllMedicinesInitial extends GetAllMedicinesState {}

class GetAllMedicinesLoading extends GetAllMedicinesState {}

class GetAllMedicinesLoaded extends GetAllMedicinesState {
  final GetAllMedicinesModel getAllMedicinesModel;

  GetAllMedicinesLoaded({required this.getAllMedicinesModel});
}

class GetAllMedicinesError extends GetAllMedicinesState {}
