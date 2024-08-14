import 'package:coba_test/controllers/report_pdf_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../controllers/transaction_detail_controller.dart';

class TransactionDetailPage extends StatelessWidget {
  final TransactionDetailController transactionDetailController = Get.put(TransactionDetailController());
  final ReportPdfController reportPdfController = Get.put(ReportPdfController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Transaction Detail'),
        backgroundColor: Colors.white,
      ),
      body: Obx(() {
        if (transactionDetailController.isLoading.value) {
          return Center(child: CircularProgressIndicator());
        }

        var transaction = transactionDetailController.transactionDetail.value;
        return ListView(
          padding: const EdgeInsets.all(16.0),
          children: [
            _buildDetailRow('Customer Name', transaction['name']),
            _buildDetailRow('Unit Location', transaction['address']),
            _buildDetailRow('Unit Model', transaction['model']),
            _buildDetailRow('Serial Number', transaction['unit']?['serialno']),
            _buildDetailRow('Unit Number', transaction['unit_no']),
            _buildDetailRow('Component', transaction['component']),
            _buildDetailRow('Component Matrix', transaction['oil_matrix']),
            _buildDetailRow('Recommendation 1', transaction['recomm1']),
            _buildDetailRow('Recommendation 2', transaction['recomm2']),
            SizedBox(height: 20), // Space before the button
            ElevatedButton(
              onPressed: () {
                reportPdfController.exportPdf(transaction['token']);
              },
              child: Text('Export PDF'),
              style: ElevatedButton.styleFrom(
                padding: EdgeInsets.symmetric(vertical: 16.0),
                textStyle: TextStyle(fontSize: 16),
                backgroundColor: Colors.blueGrey, // Use backgroundColor instead of primary
                foregroundColor: Colors.white, // Use foregroundColor for text color
              ),
            ),
          ],
        );
      }),
    );
  }

  Widget _buildDetailRow(String label, String? value) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 12.0),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Expanded(
            child: Text(
              '$label: ',
              style: TextStyle(fontWeight: FontWeight.bold),
            ),
          ),
          Expanded(
            child: Text(
              value ?? 'N/A',
              style: TextStyle(fontSize: 16.0),
              overflow: TextOverflow.ellipsis,
            ),
          ),
        ],
      ),
    );
  }
}
