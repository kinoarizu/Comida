import 'package:comida/shared/color.dart';
import 'package:comida/shared/font.dart';
import 'package:comida/shared/size.dart';
import 'package:comida/states/bloc/page_bloc.dart';
import 'package:comida/utils/location_util.dart';
import 'package:comida/utils/storage_util.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';

class LocationPermissionScreen extends StatefulWidget {
  @override
  _LocationPermissionScreenState createState() => _LocationPermissionScreenState();
}

class _LocationPermissionScreenState extends State<LocationPermissionScreen> {
  bool isAllowClicked = false;

  @override
  Widget build(BuildContext context) {
    SystemChrome.setEnabledSystemUIOverlays(SystemUiOverlay.values);

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
                height: 90,
              ),
              Image.asset(
                "assets/image/splash_logo.png",
                width: 152,
                height: 52,
              ),
              SizedBox(
                height: 3,
              ),
              Text(
                "Fast Food Market",
                style: semiBoldBaseFont.copyWith(
                  fontSize: 13,
                  letterSpacing: -0.33,
                ),
              ),
              SizedBox(
                height: 40,
              ),
              if (!isAllowClicked) AlertDialog(
                elevation: 0,
                backgroundColor: baseColor,
                buttonPadding: EdgeInsets.zero,
                contentPadding: EdgeInsets.symmetric(vertical: 32),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(16),
                  side: BorderSide(
                    color: borderColor,
                    width: 1.5,
                  ),
                ),
                content: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Image.asset(
                      "assets/image/ic_location_permission.png",
                      width: 46,
                      height: 56,
                    ),
                    SizedBox(
                      height: 32,
                    ),
                    Text(
                      "Location Permission",
                      style: semiBoldBaseFont.copyWith(fontSize: 18),
                    ),
                    SizedBox(
                      height: 10,
                    ),
                    Text(
                      "Comida needs your authorization\nto locate your position and\nnearby places.",
                      textAlign: TextAlign.center,
                      style: regularBaseFont.copyWith(
                        fontSize: 13,
                        color: Color(0xFFBEBEBE),
                      ),
                    ),
                  ],
                ),
                actions: [
                  SizedBox(
                    width: deviceWidth(context),
                    child: FlatButton(
                      padding: EdgeInsets.symmetric(vertical: 13),
                      materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
                      splashColor: whiteColor.withOpacity(0.1),
                      child: Text(
                        "Allow",
                        style: mediumBaseFont.copyWith(fontSize: 16),
                      ),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.only(
                          bottomLeft: Radius.circular(16),
                          bottomRight: Radius.circular(16),
                        ),
                        side: BorderSide(
                          color: borderColor,
                          width: 1.5,
                        ),
                      ),
                      onPressed: onAllowPressed,
                    ),
                  ),
                ],
              ) else Padding(
                padding: EdgeInsets.only(
                  top: 130,
                ),
                child: Center(
                  child: SpinKitFadingCircle(
                    color: whiteColor,
                    size: 70,
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  void onAllowPressed() async {
    setState(() {
      isAllowClicked = true;
    });

    bool isGranted = await LocationUtil.enableGPS();

    if (isGranted) {
      if (StorageUtil.hasStorage('token')) {
        context.bloc<PageBloc>().add(GoToMainScreen());
      } else {
        context.bloc<PageBloc>().add(GoToSignInScreen());
      }
    } else {
      setState(() {
        isAllowClicked = false;
      });
    }
  }
}