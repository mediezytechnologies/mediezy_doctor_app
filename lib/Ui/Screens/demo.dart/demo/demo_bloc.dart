import 'dart:developer';

import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';

part 'demo_event.dart';
part 'demo_state.dart';

class LandingPageBloc extends Bloc<LandingPageEvent, LandingPageState> {
  LandingPageBloc() : super(const LandingPageInitial(tabIndex: 0)) {
    on<LandingPageEvent>((event, emit) {
      if (event is TabChange) {
        log(event.tabIndex.toString());
        emit(LandingPageInitial(tabIndex: event.tabIndex));
      }
    });
  }
}
