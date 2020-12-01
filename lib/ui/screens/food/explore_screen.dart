part of 'package:comida/ui/screens/screens.dart';

class ExploreScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    SystemChrome.setEnabledSystemUIOverlays(SystemUiOverlay.values);
    context.bloc<UserBloc>().add(LoadUser());

    return Scaffold(
      body: Container(
        child: Center(
          child: BlocBuilder<UserBloc, UserState>(
            builder: (_, userState) {
              if (userState is UserLoaded) {
                return Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      userState.user.name,
                    ),
                    SizedBox(
                      height: 10,
                    ),
                    RaisedButton(
                      child: Text(
                        "Sign Out",
                      ),
                      onPressed: () async {
                        await AuthRepository.signOut();
                        context.bloc<UserBloc>().add(SignOut());
                        context.bloc<PageBloc>().add(GoToSignInScreen());
                      },
                    ),
                  ],
                );
              } else {
                return SpinKitFadingCircle(
                  color: baseColor,
                  size: 50,
                );
              }
            }
          ),
        ),
      ),
    );
  }
}