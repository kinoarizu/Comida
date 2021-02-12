import 'package:comida/network/services/dynamic_link_service.dart';
import 'package:comida/states/bloc/page_bloc.dart';
import 'package:comida/ui/screens/auth/check_email_screen.dart';
import 'package:comida/ui/screens/auth/email_verification_screen.dart';
import 'package:comida/ui/screens/auth/number_address_screen.dart';
import 'package:comida/ui/screens/auth/reset_password_screen.dart';
import 'package:comida/ui/screens/auth/sign_in_screen.dart';
import 'package:comida/ui/screens/auth/sign_up_screen.dart';
import 'package:comida/ui/screens/food/maps_screen.dart';
import 'package:comida/ui/screens/static/location_permission_screen.dart';
import 'package:comida/ui/screens/static/main_screen.dart';
import 'package:comida/ui/screens/static/splash_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

/// Handling page routing using bloc state management architecture.

class Wrapper extends StatefulWidget {
  @override
  _WrapperState createState() => _WrapperState();
}

class _WrapperState extends State<Wrapper> {
  @override
  void initState() {
    super.initState();
    DynamicLinkService.retrieveDynamicLink(context);
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<PageBloc, PageState>(
      builder: (_, pageState) =>

        (pageState is OnSplashScreen)
        ? SplashScreen()
      
        : (pageState is OnLocationPermissionScreen)
        ? LocationPermissionScreen()

        : (pageState is OnSignInScreen)
        ? SignInScreen()

        : (pageState is OnSignUpScreen)
        ? SignUpScreen(pageState.auth)

        : (pageState is OnNumberAddressScreen)
        ? NumberAddressScreen(pageState.auth)

        : (pageState is OnEmailVerificationScreen)
        ? EmailVerificationScreen(pageState.auth)

        : (pageState is OnCheckEmailScreen)
        ? CheckEmailScreen()

        : (pageState is OnResetPasswordScreen)
        ? ResetPasswordScreen()

        : (pageState is OnMainScreen)
        ? MainScreen()

        : (pageState is OnMapsScreen)
        ? MapsScreen()

        : Container()
        
    );
  }
}