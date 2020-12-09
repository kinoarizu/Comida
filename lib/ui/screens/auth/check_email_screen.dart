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

class CheckEmailScreen extends StatefulWidget {
  @override
  _CheckEmailScreenState createState() => _CheckEmailScreenState();
}

class _CheckEmailScreenState extends State<CheckEmailScreen> {
  TextEditingController emailController = TextEditingController();

  bool isClicked = false;

    @override
  Widget build(BuildContext context) {
    return Consumer<ValidationProvider>(
      builder: (context, validation, _) => WillPopScope(
        onWillPop: () async {
          context.bloc<PageBloc>().add(GoToSignInScreen());
          validation.resetChange();
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
                    height: deviceHeight(context) - statusBarHeight(context),
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
                                  "Check Email",
                                  style: semiBoldBaseFont.copyWith(fontSize: 20),
                                ),
                              ),
                            ],
                          ),
                          SizedBox(
                            height: 36,
                          ),
                          Align(
                            alignment: Alignment.centerLeft,
                            child: Text(
                              "We will send reset password link to your email. Please enter your email account registered.",
                              style: regularBaseFont.copyWith(fontSize: 12),
                            ),
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
                          if (isClicked) Padding(
                            padding: EdgeInsets.only(
                              top: 32,
                              bottom: 79,
                            ),
                            child: SpinKitThreeBounce(
                              color: whiteColor,
                              size: 45,
                            ),
                          ) else BaseButton(
                            width: 150,
                            height: 45,
                            color: (validation.errorEmail == "") ? accentColor : greyColor,
                            margin: EdgeInsets.only(
                              top: 32,
                              bottom: 79,
                            ),
                            child: Icon(
                              LineAwesomeIcons.long_arrow_right,
                              size: 24,
                              color: whiteColor,
                            ),
                            onPressed: (validation.errorEmail == "") ? () {
                              setState(() {
                                isClicked = true;
                              });
                              onCheckEmailPressed(
                                context,
                                email: emailController.text,
                                validation: validation,
                              );
                            } : null,
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

  void onCheckEmailPressed(BuildContext context, {String email, ValidationProvider validation}) async {
    ResponseUtil response = await AuthRepository.sendReset(email);

    if (response.statusCode == 200) {
      setState(() {
        emailController.text = '';
      });

      validation.resetChange();

      showValidationBar(
        context,
        color: Color(0xFF1ABC9C),
        icon: Icons.check_circle_outline,
        message: "We have sent reset password link, please check your email inbox!",
      );
    } else {
      showValidationBar(
        context,
        color: Color(0xFFD9435E),
        icon: Icons.error_outline,
        message: "Your email is not registered!",
      );
    }
    
    setState(() {
      isClicked = false;
    });
  }
}