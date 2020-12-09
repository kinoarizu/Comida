import 'package:comida/network/repositories/auth_repository.dart';
import 'package:comida/utils/response_util.dart';
import 'package:comida/utils/storage_util.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_facebook_auth/flutter_facebook_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:comida/model/auth.dart' as model;

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

    final ResponseUtil response = await AuthRepository.social(
      model.Auth(
        name: googleSignInAccount.displayName,
        email: googleSignInAccount.email,
      ),
    );

    if (response.statusCode != 200) {
      return ResponseUtil.resultResponse(
        data: null,
        statusCode: 422,
      );
    }
    
    final GoogleSignInAuthentication googleSignInAuthentication = await googleSignInAccount.authentication;

    final OAuthCredential credential = GoogleAuthProvider.credential(
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

      final Map<String, dynamic> facebookData = await FacebookAuth.instance.getUserData();
      
      final ResponseUtil response = await AuthRepository.social(
        model.Auth(
          name: facebookData['name'],
          email: facebookData['email'],
        ),
      );

      if (response.statusCode != 200) {
        return ResponseUtil.resultResponse(
          data: null,
          statusCode: 422,
        );
      }
      
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