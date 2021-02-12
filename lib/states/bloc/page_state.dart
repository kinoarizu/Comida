part of 'page_bloc.dart';

/// Declaring all states of page bloc architecture.

abstract class PageState extends Equatable {
  const PageState();
}

class OnSplashScreen extends PageState {
  @override
  List<Object> get props => [];
}

class OnLocationPermissionScreen extends PageState {
  @override
  List<Object> get props => [];
}

class OnSignInScreen extends PageState {
  @override
  List<Object> get props => [];
}

class OnSignUpScreen extends PageState {
  final Auth auth;

  OnSignUpScreen(this.auth);

  @override
  List<Object> get props => [auth];
}

class OnNumberAddressScreen extends PageState {
  final Auth auth;

  OnNumberAddressScreen(this.auth);

  @override
  List<Object> get props => [auth];
}

class OnEmailVerificationScreen extends PageState {
  final Auth auth;

  OnEmailVerificationScreen(this.auth);

  @override
  List<Object> get props => [auth];
}

class OnCheckEmailScreen extends PageState {
  @override
  List<Object> get props => [];
}

class OnResetPasswordScreen extends PageState {
  @override
  List<Object> get props => [];
}

class OnMainScreen extends PageState {
  @override
  List<Object> get props => [];
}

class OnMapsScreen extends PageState {
  @override
  List<Object> get props => [];
}