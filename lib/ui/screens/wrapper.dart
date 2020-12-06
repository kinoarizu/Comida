part of 'screens.dart';

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

        : (pageState is OnExploreScreen)
        ? ExploreScreen()

        : Container()
        
    );
  }
}