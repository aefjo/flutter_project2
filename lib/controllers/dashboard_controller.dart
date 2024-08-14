import 'package:get/get.dart';

class DashboardController extends GetxController {
  final GetConnect _connect = GetConnect();

  var totalNormal = '0'.obs;
  var totalCaution = '0'.obs;
  var totalCritical = '0'.obs;
  var totalSevere = '0'.obs;

  void fetchDashboardData(String username) async {
    var url = 'http://ut.petrolab.co.id/api/transaction/unit/summary?username=$username';

    try {
      final response = await _connect.get(url);

      if (response.statusCode == 200) {
        var data = response.body['data'];
        totalNormal.value = data['total_normal'] ?? '0';
        totalCaution.value = data['total_caution'] ?? '0';
        totalCritical.value = data['total_critical'] ?? '0';
        totalSevere.value = data['total_severe'] ?? '0';
      } else {
        Get.snackbar('Error', 'Failed to load dashboard data');
      }
    } catch (e) {
      Get.snackbar('Error', 'An error occurred while fetching data');
    }
  }
}





