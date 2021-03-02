import 'package:comida/model/user.dart';
import 'package:comida/shared/value.dart';
import 'package:comida/utils/storage_util.dart';
import 'package:dio/dio.dart';

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
          'Accept': 'application/json',
          'Content-Type': 'application/json',
        },
      ),
    );
    
    return User.fromJson(response.data['data']);
  }
}