part of 'package:comida/ui/screens/screens.dart';

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
                              onCheckEmailPressed(context);
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

  void onCheckEmailPressed(BuildContext context) {
    context.bloc<PageBloc>().add(GoToResetPasswordScreen());
    Provider.of<ValidationProvider>(context, listen: false).resetChange();
  }
}