part of 'page_bloc.dart';

/// Declaring all events of page bloc architecture.

abstract class PageEvent extends Equatable {
  const PageEvent();
}

class GoToSplashScreen extends PageEvent {
  @override
  List<Object> get props => [];
}

class GoToLocationPermissionScreen extends PageEvent {
  @override
  List<Object> get props => [];
}

class GoToSignInScreen extends PageEvent {
  @override
  List<Object> get props => [];
}

class GoToSignUpScreen extends PageEvent {
  final Auth auth;

  GoToSignUpScreen(this.auth);

  @override
  List<Object> get props => [auth];
}

class GoToNumberAddressScreen extends PageEvent {
  final Auth auth;

  GoToNumberAddressScreen(this.auth);

  @override
  List<Object> get props => [auth];
}

class GoToEmailVerificationScreen extends PageEvent {
  final Auth auth;

  GoToEmailVerificationScreen(this.auth);

  @override
  List<Object> get props => [auth];
}

class GoToCheckEmailScreen extends PageEvent {
  @override
  List<Object> get props => [];
}

class GoToResetPasswordScreen extends PageEvent {
  @override
  List<Object> get props => [];
}

class GoToMainScreen extends PageEvent {
  @override
  List<Object> get props => [];
}