part of 'screens.dart';

class Wrapper extends StatelessWidget {
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

        : Container()
        
    );
  }
}