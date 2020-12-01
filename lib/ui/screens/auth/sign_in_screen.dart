part of 'package:comida/ui/screens/screens.dart';

class SignInScreen extends StatefulWidget {
  @override
  _SignInScreenState createState() => _SignInScreenState();
}

class _SignInScreenState extends State<SignInScreen> {
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();

  bool isHidePassword = false;
  bool isLogining = false;

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
                            BaseButton(
                              width: 150,
                              height: 45,
                              color: whiteColor,
                              onPressed: () {},
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
                            BaseButton(
                              width: 150,
                              height: 45,
                              color: blueColor,
                              onPressed: () {},
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
      context.bloc<PageBloc>().add(GoToExploreScreen());
      Provider.of<ValidationProvider>(context, listen: false).resetChange();
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
}