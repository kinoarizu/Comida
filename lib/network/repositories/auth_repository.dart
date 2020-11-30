part of 'repositories.dart';

class AuthRepository {
  static Future<ResponseUtil> signIn(Auth auth) async {
    String apiURL = apiBaseURL + '/auth/login';

    FormData authData = FormData.fromMap({
      'email': auth.email,
      'password': auth.password,
    });

    final response = await Dio().post(
      apiURL,
      data: authData,
      options: Options(
        followRedirects: false, 
        validateStatus: (status) { return status < 500; },
      ),
    );

    final meta = response.data['meta'];
    final data = response.data['data'];

    if (response.statusCode == 200) {
      GetStorage box = GetStorage();
      box.write('token', data['access_token']);

      return ResponseUtil.resultResponse(
        message: meta['message'],
        data: User.fromJson(data['user']),
        statusCode: response.statusCode,
      );
    }

    return ResponseUtil.resultResponse(
      message: meta['message'],
      error: data['error'],
      statusCode: response.statusCode,
    );
  }
} 