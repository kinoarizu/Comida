part of 'repositories.dart';

class UserRepository {
  static Future<User> getUser() async {
    String apiURL = apiBaseURL + '/user';

    final String token = StorageUtil.readStorage('token');

    final response = await Dio().get(
      apiURL,
      options: Options(
        followRedirects: false, 
        validateStatus: (status) { return status <= 500; },
        headers: {
          'Authorization': 'Bearer $token',
        },
      ),
    );
    
    return User.fromJson(response.data['data']);
  }
}