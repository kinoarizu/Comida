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
        validateStatus: (status) { return status <= 500; },
      ),
    );

    final meta = response.data['meta'];
    final data = response.data['data'];

    if (response.statusCode == 200) {
      StorageUtil.writeStorage('token', data['access_token']);

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

  static Future<ResponseUtil> signUp(Auth auth, {String code}) async {
    String apiURL = apiBaseURL + '/auth/register';

    FormData authData = FormData.fromMap({
      'name': auth.name,
      'email': auth.email,
      'password': auth.password,
      'password_confirmation': auth.confirmPassword,
      'phone_number': auth.phoneNumber,
      'address': auth.address,
      'code': code,
    });

    final response = await Dio().post(
      apiURL,
      data: authData,
      options: Options(
        followRedirects: false, 
        validateStatus: (status) { return status <= 500; },
      ),
    );

    final meta = response.data['meta'];
    final data = response.data['data'];

    if (response.statusCode == 200) {
      StorageUtil.writeStorage('token', data['access_token']);

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

  static Future<ResponseUtil> verification(String name, String email) async {
    String apiURL = apiBaseURL + '/auth/verification';

    FormData authData = FormData.fromMap({
      'name': name,
      'email': email,
    });

    final response = await Dio().post(
      apiURL,
      data: authData,
      options: Options(
        followRedirects: false, 
        validateStatus: (status) { return status <= 500; },
      ),
    );

    final meta = response.data['meta'];
    final data = response.data['data'];

    if (response.statusCode == 200) {
      return ResponseUtil.resultResponse(
        message: meta['message'],
        data: data,
        statusCode: response.statusCode,
      );
    }

    return ResponseUtil.resultResponse(
      message: meta['message'],
      error: data['error'],
      statusCode: response.statusCode,
    );
  }

  static Future<ResponseUtil> signOut() async {
    String apiURL = apiBaseURL + '/logout';

    final String token = StorageUtil.readStorage('token');

    final response = await Dio().post(
      apiURL,
      options: Options(
        followRedirects: false, 
        validateStatus: (status) { return status <= 500; },
        headers: {
          'Authorization': 'Bearer $token',
        },
      ),
    );

    final meta = response.data['meta'];

    StorageUtil.removeStorage('token');

    return ResponseUtil.resultResponse(
      message: meta['message'],
      statusCode: response.statusCode,
    );
  }

  static Future<ResponseUtil> sendReset(String email) async {
    String apiURL = apiBaseURL + '/auth/password/send';

    FormData authData = FormData.fromMap({
      'email': email,
    });

    final response = await Dio().post(
      apiURL,
      data: authData,
      options: Options(
        followRedirects: false, 
        validateStatus: (status) { return status <= 500; },
      ),
    );

    final meta = response.data['meta'];
    final data = response.data['data'];

    if (response.statusCode == 200) {
      return ResponseUtil.resultResponse(
        message: meta['message'],
        data: data['access_token'],
        statusCode: response.statusCode,
      );
    }

    return ResponseUtil.resultResponse(
      message: meta['message'],
      error: data['error'],
      statusCode: response.statusCode,
    );
  }

  static Future<ResponseUtil> updatePassword(Auth auth) async {
    String apiURL = apiBaseURL + '/auth/password/reset?_method=PUT';

    User fetchedUser = await fetchUser();

    FormData authData = FormData.fromMap({
      'id': fetchedUser.id,
      'password': auth.password,
      'password_confirmation': auth.confirmPassword,
    });

    final response = await Dio().post(
      apiURL,
      data: authData,
      options: Options(
        followRedirects: false, 
        validateStatus: (status) { return status <= 500; },
      ),
    );

    final meta = response.data['meta'];

    return ResponseUtil.resultResponse(
      message: meta['message'],
      statusCode: response.statusCode,
    );
  }

  static Future<ResponseUtil> social(Auth auth) async {
    String apiURL = apiBaseURL + '/auth/social';

    FormData authData = FormData.fromMap({
      'name': auth.name,
      'email': auth.email,
    });

    final response = await Dio().post(
      apiURL,
      data: authData,
      options: Options(
        followRedirects: false, 
        validateStatus: (status) { return status <= 500; },
      ),
    );

    final meta = response.data['meta'];
    final data = response.data['data'];

    if (response.statusCode == 200) {
      return ResponseUtil.resultResponse(
        message: meta['message'],
        data: data['access_token'],
        statusCode: response.statusCode,
      );
    }

    return ResponseUtil.resultResponse(
      message: meta['message'],
      error: data['error'],
      statusCode: response.statusCode,
    );
  }

  static Future<User> fetchUser() async {
    String apiURL = apiBaseURL + '/user';

    final String resetToken = StorageUtil.readStorage('reset_token');

    final response = await Dio().get(
      apiURL,
      options: Options(
        followRedirects: false, 
        validateStatus: (status) { return status <= 500; },
        headers: {
          'Authorization': 'Bearer $resetToken',
        },
      ),
    );
    
    return User.fromJson(response.data['data']);
  }
} 