import 'package:get/get.dart';

class AuthController extends GetxController {


  final GetConnect _connect = GetConnect();
  var isLoggedIn = false.obs;
  var userToken = ''.obs;
  var username = ''.obs;

  void login(String username, String password) async {
    var url = 'http://api.ut.petrolab.co.id/users/login';
    
    try {
      final response = await _connect.post(url, {
        'username': username,
        'password': password,
      });

      print('=============================================================================');

      print('Response Body : ${response.body}');
      print('status code : ${response.statusCode}');
      print('username : ${username}');
      print('password : ${password}');

      if (response.statusCode == 200) {
        var data = response.body;
        this.username.value = data['user']['username']; // Simpan username dari API
        userToken.value = data['token_key'];
        isLoggedIn.value = true;
        Get.offAllNamed('/dashboard');

        print('Login Berhasil');
        print('=============================================================================');
      } else {
        print('status code : ${response.statusCode}');
        print('=============================================================================');
        Get.snackbar('Login Failed', 'Invalid credentials');
      }
    } catch (e) {
      // Menangani error yang tidak terduga
      print('Login failed: $e');
      Get.snackbar('Login Failed', 'An unexpected error occurred. Please try again later.');
    }
  }

  void logout() {
    isLoggedIn.value = false;
    userToken.value = '';
    Get.offAllNamed('/login');
  }
}
