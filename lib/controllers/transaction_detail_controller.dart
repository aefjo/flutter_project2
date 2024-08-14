import 'package:get/get.dart';

class TransactionDetailController extends GetxController {
  final GetConnect _connect = GetConnect();
  var transactionDetail = {}.obs;
  var isLoading = true.obs;

  @override
  void onInit() {
    super.onInit();
    String labNo = Get.arguments; // Mendapatkan parameter dari navigasi
    fetchTransactionDetail(labNo);
  }

  void fetchTransactionDetail(String labNo) async {
    isLoading.value = true;
    var url = 'http://api.ut.petrolab.co.id/transaction/detail/$labNo';

    try {
      final response = await _connect.get(url);

      if (response.status.hasError) {
        Get.snackbar('Error', 'Failed to load transaction details');
      } else {
        transactionDetail.value = response.body;
      }
    } catch (e) {
      Get.snackbar('Error', 'An unexpected error occurred');
    } finally {
      isLoading.value = false;
    }
  }
}
