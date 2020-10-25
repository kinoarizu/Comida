import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:comida/model/model.dart';
import 'package:equatable/equatable.dart';

part 'page_event.dart';
part 'page_state.dart';

class PageBloc extends Bloc<PageEvent, PageState> {
  PageBloc() : super(OnSplashScreen());

  @override
  Stream<PageState> mapEventToState(PageEvent event) async* {
    if (event is GoToSplashScreen) {
      yield OnSplashScreen();
    }
    else if (event is GoToLocationPermissionScreen) {
      yield OnLocationPermissionScreen();
    }
    else if (event is GoToSignInScreen) {
      yield OnSignInScreen();
    }
    else if (event is GoToSignUpScreen) {
      yield OnSignUpScreen(event.auth);
    }
    else if (event is GoToNumberAddressScreen) {
      yield OnNumberAddressScreen(event.auth);
    }
    else if (event is GoToEmailVerificationScreen) {
      yield OnEmailVerificationScreen(event.auth);
    }
    else if (event is GoToCheckEmailScreen) {
      yield OnCheckEmailScreen();
    }
    else if (event is GoToResetPasswordScreen) {
      yield OnResetPasswordScreen();
    }
  }
}
