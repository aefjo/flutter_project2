import 'package:get/get.dart';
import 'package:url_launcher/url_launcher.dart';

class ReportPdfController extends GetxController {

  void exportPdf(String token) async {
    final String pdfUrl = 'https://ut.petrolab.co.id/report/show/pdf?token=$token';
    try {
      if (await canLaunch(pdfUrl)) {
        await launch(pdfUrl);
      } else {
        // Jika URL tidak dapat diluncurkan, lempar pengecualian
        throw 'Could not launch $pdfUrl';
      }
    } catch (e) {
      // Tangani kesalahan di sini, misalnya menampilkan pesan kesalahan
      print('Error occurred: $e');
      Get.snackbar(
        'Error',
        'Could not open PDF: $e',
        snackPosition: SnackPosition.BOTTOM,
      );
    }
  }
}
