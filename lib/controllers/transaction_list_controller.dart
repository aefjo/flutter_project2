import 'package:get/get.dart';
import '../controllers/auth_controller.dart';

class TransactionListController extends GetxController {
  final GetConnect _connect = GetConnect();
  var transactions = <Map<String, dynamic>>[].obs;
  var isLoading = true.obs;
  final AuthController authController = Get.find<AuthController>();

  @override
  void onInit() {
    fetchTransactions();
    super.onInit();
  }

  void fetchTransactions() async {
    isLoading.value = true;
    var username = authController.username.value;
    var url = 'https://ut.petrolab.co.id/api/transaction?page=0&username=$username';

    try {
      final response = await _connect.get(url);

      if (response.status.hasError) {
        Get.snackbar('Error', 'Failed to load transactions');
      } else {
        transactions.value = List<Map<String, dynamic>>.from(response.body['data']);
      }
    } catch (e) {
      Get.snackbar('Error', 'An unexpected error occurred');
    } finally {
      isLoading.value = false;
    }

    print(transactions);
  }

  void searchTransactions(String labNo) async {
    if (labNo.isEmpty) {
      fetchTransactions();
      Get.snackbar('Peringatan', 'Nomor Lab tidak boleh kosong.');
      return;
    }

    isLoading.value = true;
    var url = 'https://ut.petrolab.co.id/api/transaction/default/search?username=demo&labnumber=$labNo';

    try {
      final response = await _connect.get(url);

      print(response.statusCode);
      print(response.body);

      if (response.statusCode == 200) {
        transactions.value = List<Map<String, dynamic>>.from(response.body['data']);
      } else {
        Get.snackbar('Error', 'Gagal memuat data. Status: ${response.statusCode}');
      }
    } catch (e) {
      Get.snackbar('Error', 'Terjadi kesalahan: $e');
    } finally {
      isLoading.value = false;
    }
  }

}
