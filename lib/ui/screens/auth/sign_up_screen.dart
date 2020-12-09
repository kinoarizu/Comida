import 'package:comida/model/auth.dart';
import 'package:comida/network/repositories/auth_repository.dart';
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
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:line_awesome_icons/line_awesome_icons.dart';
import 'package:provider/provider.dart';

class SignUpScreen extends StatefulWidget {
  final Auth auth;

  SignUpScreen(this.auth);

  @override
  _SignUpScreenState createState() => _SignUpScreenState();
}

class _SignUpScreenState extends State<SignUpScreen> {
  TextEditingController nameController = TextEditingController();
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  TextEditingController confirmationController = TextEditingController();

  bool isHidePassword = false;
  bool isHidePasswordConfirmation = false;
  bool isClicked = false;

  @override
  void initState() {
    super.initState();

    nameController.text = widget.auth.name;
    emailController.text = widget.auth.email;
    passwordController.text = widget.auth.password;
    confirmationController.text = widget.auth.confirmPassword;
  }
  
  @override
  Widget build(BuildContext context) {
    return Consumer<ValidationProvider>(
      builder: (context, validation, _) => WillPopScope(
        onWillPop: () async {
          context.bloc<PageBloc>().add(GoToSignInScreen());
          validation.resetChange(); 
          validation.resetChangeNumberAddress();
          validation.resetVerificationCode();
          return;
        },
        child: Scaffold(
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
                      child: Column(
                        children: [
                          SizedBox(
                            height: 32,
                          ),
                          Stack(
                            children: [
                              Align(
                                alignment: Alignment.centerLeft,
                                child: GestureDetector(
                                  onTap: () {
                                    context.bloc<PageBloc>().add(GoToSignInScreen());
                                    validation.resetChange(); 
                                    validation.resetChangeNumberAddress();
                                    validation.resetVerificationCode();     
                                  },
                                  child: Icon(
                                    LineAwesomeIcons.angle_left,
                                    color: whiteColor,
                                    size: 24,
                                  ),
                                ),
                              ),
                              Align(
                                alignment: Alignment.center,
                                child: Text(
                                  "Sign Up",
                                  style: semiBoldBaseFont.copyWith(fontSize: 20),
                                ),
                              ),
                            ],
                          ),
                          SizedBox(
                            height: 36,
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
                            height: 32,
                          ),
                          DarkTextField(
                            labelText: "Full Name",
                            hintText: "Enter Your Name",
                            controller: nameController,
                            errorValidation: validation.errorName,
                            onChanged: (text) {
                              validation.changeName(text);
                            },
                          ),
                          SizedBox(
                            height: 16,
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
                            onChanged: (value) {
                              validation.changePassword(value);
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
                            height: 16,
                          ),
                          DarkTextField(
                            labelText: "Confirm Password",
                            hintText: "Enter Confirm Password",
                            obscureText: !isHidePasswordConfirmation,
                            controller: confirmationController,
                            errorValidation: validation.errorPasswordConfirmation,
                            onChanged: (value) {
                              validation.changePasswordConfirmation(value, passwordController.text);
                            },
                            suffixIcon: GestureDetector(
                              onTap: () {
                                setState(() {
                                  isHidePasswordConfirmation = !isHidePasswordConfirmation;
                                });
                              },
                              child: Theme(
                                data: Theme.of(context).copyWith(primaryColor: null),
                                child: (!isHidePasswordConfirmation) ? Icon(
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
                          if (isClicked) Padding(
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
                            color: (validation.isAllValidate()) ? accentColor : greyColor,
                            margin: EdgeInsets.only(
                              top: 32,
                              bottom: 16,
                            ),
                            child: Icon(
                              LineAwesomeIcons.long_arrow_right,
                              size: 24,
                              color: whiteColor,
                            ),
                            onPressed: (validation.isAllValidate()) ? () {
                              setState(() {
                                isClicked = true;
                              });
                              onSignUpPressed(context);
                            } : null,
                          ),
                          SizedBox(
                            height: 24,
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Text(
                                "Already a member, ",
                                style: mediumBaseFont.copyWith(fontSize: 13),
                              ),
                              GestureDetector(
                                onTap: () {
                                  context.bloc<PageBloc>().add(GoToSignInScreen());
                                  validation.resetChange(); 
                                  validation.resetChangeNumberAddress();
                                  validation.resetVerificationCode();
                                },
                                child: Text(
                                  "Sign In",
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
            ],
          ),
        ),
      ),
    );
  }

  void onSignUpPressed(BuildContext context) async {
    widget.auth.name = nameController.text;
    widget.auth.email = emailController.text;
    widget.auth.password = passwordController.text;
    widget.auth.confirmPassword = confirmationController.text;

    ResponseUtil response = await AuthRepository.signUp(
      Auth(
        name: widget.auth.name,
        email: widget.auth.email,
        password: widget.auth.password,
        confirmPassword: widget.auth.confirmPassword,
      ),
    );

    if (response.error['email'] == null) {
      context.bloc<PageBloc>().add(GoToNumberAddressScreen(widget.auth));
    } else {
      setState(() {
        isClicked = false;
      });

      showValidationBar(
        context,
        color: Color(0xFFD9435E),
        icon: Icons.error_outline,
        message: "Your email address has been used!",
      );
    }
  }
}