part of 'services.dart';

class SocialAuthService {
  static FirebaseAuth _auth = FirebaseAuth.instance;
  static GoogleSignIn _googleSignIn = GoogleSignIn();

  static Future<ResponseUtil> signInGoogle() async {
    final GoogleSignInAccount googleSignInAccount = await _googleSignIn.signIn();

    if (googleSignInAccount == null) {
      return ResponseUtil.resultResponse(
        data: null,
        message: 'Google Sign In Cancelled',
        statusCode: 400,
      );
    }
    
    final GoogleSignInAuthentication googleSignInAuthentication = await googleSignInAccount.authentication;

    final AuthCredential credential = GoogleAuthProvider.credential(
      accessToken: googleSignInAuthentication.accessToken,
      idToken: googleSignInAuthentication.idToken,
    );

    final UserCredential authResult = await _auth.signInWithCredential(credential);
    final User user = authResult.user;

    StorageUtil.writeStorage('token', googleSignInAuthentication.accessToken);
    StorageUtil.writeStorage('status', 'google');

    return ResponseUtil.resultResponse(
      data: user,
      message: 'Success Google Sign In',
      statusCode: 200,
    );
  }

  static Future<ResponseUtil> signOutGoogle() async {
    await _googleSignIn.signOut();
    await FirebaseAuth.instance.signOut();

    StorageUtil.removeStorage('token');
    StorageUtil.removeStorage('status');

    return ResponseUtil.resultResponse(
      message: 'Success Google Sign Out',
      statusCode: 200,
    );
  }

  static Future<ResponseUtil> signInFacebook() async {
    try {
      final AccessToken accessToken = await FacebookAuth.instance.login(
        loginBehavior: LoginBehavior.NATIVE_WITH_FALLBACK,
      );
      
      final OAuthCredential credential = FacebookAuthProvider.credential(accessToken.token);

      final UserCredential authResult = await _auth.signInWithCredential(credential);
      final User user = authResult.user;

      StorageUtil.writeStorage('token', accessToken.token);
      StorageUtil.writeStorage('status', 'facebook');

      return ResponseUtil.resultResponse(
        data: user,
        message: 'Success Facebook Sign In',
        statusCode: 200,
      );
    } on FacebookAuthException catch (error) {
      return ResponseUtil.resultResponse(
        message: error.message,
        statusCode: 400,
      );
    }
  }

  static Future<ResponseUtil> signOutFacebook() async {
    await FacebookAuth.instance.logOut();
    await FirebaseAuth.instance.signOut();

    StorageUtil.removeStorage('token');
    StorageUtil.removeStorage('status');

    return ResponseUtil.resultResponse(
      message: 'Success Facebook Sign Out',
      statusCode: 200,
    );
  }
}