part of 'package:comida/ui/screens/screens.dart';

class SplashScreen extends StatefulWidget {
  @override
  _SplashScreenState createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() { 
    super.initState();
    _splashToNextScreen();
  }

  Future<Timer> _splashToNextScreen() async {
    bool isGPSEnabled = await LocationUtil.isGPSEnabled();

    return Timer(Duration(seconds: 5), () {
      if (!isGPSEnabled) {
        context.bloc<PageBloc>().add(GoToLocationPermissionScreen());
      } else {
        if (StorageUtil.hasStorage('token')) {
          context.bloc<PageBloc>().add(GoToExploreScreen());
        } else {
          context.bloc<PageBloc>().add(GoToSignInScreen());
        }
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    SystemChrome.setEnabledSystemUIOverlays([SystemUiOverlay.bottom]);

    return Scaffold(
      body: Container(
        width: deviceWidth(context),
        height: deviceHeight(context),
        decoration: BoxDecoration(
          image: DecorationImage(
            fit: BoxFit.cover,
            image: AssetImage("assets/image/bg_splash.png"),
          ),
        ),
        child: Center(
          child: Column(
            children: [
              SizedBox(
                height: 110,
              ),
              Image.asset(
                "assets/image/splash_logo.png",
                width: 198,
                height: 68,
              ),
              SizedBox(
                height: 4,
              ),
              Text(
                "Fast Food Market",
                style: semiBoldBaseFont.copyWith(
                  fontSize: 16,
                  letterSpacing: -0.42,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}