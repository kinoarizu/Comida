part of 'package:comida/ui/screens/screens.dart';

class EmailVerificationScreen extends StatefulWidget {
  final Auth auth;

  EmailVerificationScreen(this.auth);

  @override
  _EmailVerificationScreenState createState() => _EmailVerificationScreenState();
}

class _EmailVerificationScreenState extends State<EmailVerificationScreen> {
  TextEditingController verificationCodeController = TextEditingController();

  bool isClicked = false;

  @override
  Widget build(BuildContext context) {
    return Consumer<ValidationProvider>(
      builder: (context, validation, _) => WillPopScope(
        onWillPop: () async {
          context.bloc<PageBloc>().add(GoToNumberAddressScreen(widget.auth));
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
                                    context.bloc<PageBloc>().add(GoToNumberAddressScreen(widget.auth));
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
                                  "Email Verification",
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
                              "We have sent verification code to your email address. Please check your email inbox.",
                              style: regularBaseFont.copyWith(fontSize: 12),
                            ),
                          ),
                          SizedBox(
                            height: 32,
                          ),
                          DarkTextField(
                            labelText: "Verification Code",
                            hintText: "Enter Your Verification Code",
                            controller: verificationCodeController,
                            errorValidation: validation.errorVerificationCode,
                            keyboardType: TextInputType.number,
                            inputFormatter: MaskTextInputFormatter(
                              mask: '######',
                              filter: { "#": RegExp(r'[0-9]') },
                            ),
                            onChanged: (text) {
                              validation.changeVerificationCode(text);
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
                            color: (validation.errorVerificationCode == "") ? accentColor : greyColor,
                            margin: EdgeInsets.only(
                              top: 32,
                              bottom: 79,
                            ),
                            child: Icon(
                              LineAwesomeIcons.long_arrow_right,
                              size: 24,
                              color: whiteColor,
                            ),
                            onPressed: (validation.errorVerificationCode == "") ? () {
                              setState(() {
                                isClicked = true;
                              });
                              onEmailVerificationPressed(context);
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

  void onEmailVerificationPressed(BuildContext context) {

  }
}