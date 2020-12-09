import 'package:comida/network/repositories/auth_repository.dart';
import 'package:comida/network/services/social_auth_service.dart';
import 'package:comida/shared/color.dart';
import 'package:comida/states/bloc/page_bloc.dart';
import 'package:comida/states/bloc/user_bloc.dart';
import 'package:comida/utils/storage_util.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';

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
                        onSignOutPressed(context);
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

  void onSignOutPressed(BuildContext context) async {
    if (StorageUtil.readStorage('status') == 'google') {
      await SocialAuthService.signOutGoogle();
    }
    else if (StorageUtil.readStorage('status') == 'facebook') {
      await SocialAuthService.signOutFacebook();
    }
    else {
      await AuthRepository.signOut();
    }

    context.bloc<UserBloc>().add(SignOut());
    context.bloc<PageBloc>().add(GoToSignInScreen());
  }
}