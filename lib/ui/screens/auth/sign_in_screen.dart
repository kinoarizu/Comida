import 'package:comida/model/auth.dart';
import 'package:comida/network/repositories/auth_repository.dart';
import 'package:comida/network/services/social_auth_service.dart';
import 'package:comida/shared/color.dart';
import 'package:comida/shared/font.dart';
import 'package:comida/shared/size.dart';
import 'package:comida/states/bloc/page_bloc.dart';
import 'package:comida/states/provider/validation_provider.dart';
import 'package:comida/ui/widgets/base_button.dart';
import 'package:comida/ui/widgets/dark_text_field.dart';
import 'package:comida/ui/widgets/validation_bar.dart';
import 'package:comida/utils/response_util.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:line_awesome_icons/line_awesome_icons.dart';
import 'package:provider/provider.dart';

class SignInScreen extends StatefulWidget {
  @override
  _SignInScreenState createState() => _SignInScreenState();
}

class _SignInScreenState extends State<SignInScreen> {
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();

  bool isHidePassword = false;
  bool isLogining = false;
  bool isGoogleClicked = false;
  bool isFacebookClicked = false;

  @override
  Widget build(BuildContext context) {
    SystemChrome.setEnabledSystemUIOverlays(SystemUiOverlay.values);

    final isValidEmail = Provider.of<ValidationProvider>(context).errorEmail == "";
    final isValidPassword = Provider.of<ValidationProvider>(context).errorPassword == "";

    return Scaffold(
      body: Stack(
        children: [
          Container(
            color: blackColor,
          ),
          SafeArea(
            child: SingleChildScrollView(
              child: Container(
                width: deviceWidth(context),
                padding: EdgeInsets.symmetric(horizontal: defaultMargin),
                decoration: BoxDecoration(
                  image: DecorationImage(
                    fit: BoxFit.cover,
                    image: AssetImage("assets/image/bg_splash.png"),
                  ),
                ),
                child: Center(
                  child: Consumer<ValidationProvider>(
                    builder: (context, validation, _) => Column(
                      children: [
                        SizedBox(
                          height: 52,
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
                        Text(
                          "Sign In",
                          style: semiBoldBaseFont.copyWith(fontSize: 20),
                        ),
                        SizedBox(
                          height: 32,
                        ),
                        DarkTextField(
                          labelText: "Email Address",
                          hintText: "Enter Your Email",
                          keyboardType: TextInputType.emailAddress,
                          controller: emailController,
                          errorValidation: validation.errorEmail,
                          onChanged: (text) {
                            validation.changeEmail(text);
                          },
                        ),
                        SizedBox(
                          height: 16,
                        ),
                        DarkTextField(
                          labelText: "Password",
                          hintText: "Enter Your Password",
                          obscureText: !isHidePassword,
                          controller: passwordController,
                          errorValidation: validation.errorPassword,
                          onChanged: (text) {
                            validation.changePassword(text);
                          },
                          suffixIcon: GestureDetector(
                            onTap: () {
                              setState(() {
                                isHidePassword = !isHidePassword;
                              });
                            },
                            child: Theme(
                              data: Theme.of(context).copyWith(primaryColor: null),
                              child: (!isHidePassword) ? Icon(
                                LineAwesomeIcons.eye_slash,
                                size: 24,
                                color: greyColor,
                              ) : Icon(
                                LineAwesomeIcons.eye,
                                size: 24,
                                color: greyColor,
                              ),
                            ),
                          ),
                        ),
                        SizedBox(
                          height: 8,
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: [
                            Text(
                              "Forgot Password? ",
                              style: mediumBaseFont.copyWith(fontSize: 11),
                            ),
                            GestureDetector(
                              onTap: () {
                                context.bloc<PageBloc>().add(GoToCheckEmailScreen());
                                validation.resetChange();
                              },
                              child: Text(
                                "Reset",
                                style: mediumBaseFont.copyWith(
                                  fontSize: 11,
                                  color: accentColor,
                                  decoration: TextDecoration.underline,
                                ),
                              ),
                            ),
                          ],
                        ),
                        if (isLogining) Padding(
                          padding: EdgeInsets.only(
                            top: 32,
                            bottom: 16,
                          ),
                          child: SpinKitThreeBounce(
                            color: whiteColor,
                            size: 45,
                          ),
                        ) else BaseButton(
                          width: 150,
                          height: 45,
                          color: (isValidEmail && isValidPassword) ? accentColor : greyColor,
                          margin: EdgeInsets.only(
                            top: 32,
                            bottom: 16,
                          ),
                          child: Icon(
                            LineAwesomeIcons.long_arrow_right,
                            size: 24,
                            color: whiteColor,
                          ),
                          onPressed: (isValidEmail && isValidPassword) ? () {
                            setState(() {
                              isLogining = true;
                            });
                            onSignInPressed(
                              context,
                              auth: Auth(
                                email: emailController.text,
                                password: passwordController.text,
                              ),
                            );
                          } : null,
                        ),
                        Text(
                          "Or",
                          style: semiBoldBaseFont.copyWith(fontSize: 18),
                        ),
                        SizedBox(
                          height: 16,
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            if (isGoogleClicked) SizedBox(
                              width: 150,
                              child: Center(
                                child: SpinKitThreeBounce(
                                  color: whiteColor,
                                  size: 45,
                                ),
                              ),
                            ) else BaseButton(
                              width: 150,
                              height: 45,
                              color: whiteColor,
                              onPressed: () {
                                setState(() {
                                  isGoogleClicked = true;
                                });
                                onGoogleSignInPressed();
                              },
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Image.asset(
                                    "assets/image/ic_google.png",
                                    width: 19,
                                    height: 20,
                                  ),
                                  SizedBox(
                                    width: 20,
                                  ),
                                  Text(
                                    "Google",
                                    style: semiBoldBaseFont.copyWith(
                                      fontSize: 14,
                                      color: Color(0xFF525068),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            SizedBox(
                              width: 12,
                            ),
                            if (isFacebookClicked) SizedBox(
                              width: 150,
                              child: Center(
                                child: SpinKitThreeBounce(
                                  color: whiteColor,
                                  size: 45,
                                ),
                              ),
                            ) else BaseButton(
                              width: 150,
                              height: 45,
                              color: blueColor,
                              onPressed: () {
                                setState(() {
                                  isFacebookClicked = true;
                                });
                                onFacebookLoginPressed();
                              },
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Image.asset(
                                    "assets/image/ic_facebook.png",
                                    width: 11,
                                    height: 19,
                                  ),
                                  SizedBox(
                                    width: 20,
                                  ),
                                  Text(
                                    "Facebook",
                                    style: semiBoldBaseFont.copyWith(
                                      fontSize: 14,
                                      color: whiteColor,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                        SizedBox(
                          height: 70,
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text(
                              "Not yet a member, ",
                              style: mediumBaseFont.copyWith(fontSize: 13),
                            ),
                            GestureDetector(
                              onTap: () {
                                context.bloc<PageBloc>().add(GoToSignUpScreen(Auth()));
                                validation.resetChange();
                              },
                              child: Text(
                                "Sign Up",
                                style: mediumBaseFont.copyWith(
                                  fontSize: 13,
                                  color: accentColor,
                                  decoration: TextDecoration.underline,
                                ),
                              ),
                            ),
                          ],
                        ),
                        SizedBox(
                          height: 32,
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
  
  void onSignInPressed(BuildContext context, {Auth auth}) async {
    ResponseUtil response = await AuthRepository.signIn(auth);

    if (response.statusCode == 200) {
      context.bloc<PageBloc>().add(GoToMainScreen());
      Provider.of<ValidationProvider>(context, listen: false).resetChange();
    } else if (response.statusCode == 450) {
      setState(() {
        isLogining = false;
      });

      showValidationBar(
        context,
        color: Color(0xFFD9435E),
        icon: Icons.error_outline,
        message: "Your email is not verified!",
      );
    } else {
      setState(() {
        isLogining = false;
      });

      showValidationBar(
        context,
        color: Color(0xFFD9435E),
        icon: Icons.error_outline,
        message: "Your email or password is wrong!",
      );
    }
  }

  void onGoogleSignInPressed() async {
    ResponseUtil response = await SocialAuthService.signInGoogle();

    if (response.statusCode == 200) {
      context.bloc<PageBloc>().add(GoToMainScreen());
      Provider.of<ValidationProvider>(context, listen: false).resetChange();
    } else if (response.statusCode == 422) {
      setState(() {
        isGoogleClicked = false;
      });

      showValidationBar(
        context,
        color: Color(0xFFD9435E),
        icon: Icons.error_outline,
        message: 'Email Account Has Been Registered',
      );
    } else {
      setState(() {
        isGoogleClicked = false;
      });

      showValidationBar(
        context,
        color: Color(0xFFD9435E),
        icon: Icons.error_outline,
        message: "Please select your google account!",
      );
    }
  }

  void onFacebookLoginPressed() async {
    ResponseUtil response = await SocialAuthService.loginFacebook();

    if (response.statusCode == 200) {
      context.bloc<PageBloc>().add(GoToMainScreen());
      Provider.of<ValidationProvider>(context, listen: false).resetChange();
    } else if (response.statusCode == 422) {
      setState(() {
        isGoogleClicked = false;
      });

      showValidationBar(
        context,
        color: Color(0xFFD9435E),
        icon: Icons.error_outline,
        message: 'Email Account Has Been Registered',
      );
    } else {
      setState(() {
        isFacebookClicked = false;
      });

      showValidationBar(
        context,
        color: Color(0xFFD9435E),
        icon: Icons.error_outline,
        message: "You have cancelled facebook login!",
      );
    }
  }
}