import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../controllers/transaction_list_controller.dart';

class TransactionListPage extends StatelessWidget {
  final TransactionListController transactionListController = Get.put(TransactionListController());
  final TextEditingController searchController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Transaction List'),
        automaticallyImplyLeading: false,
        bottom: PreferredSize(
          preferredSize: Size.fromHeight(60.0),
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Row(
              children: [
                Expanded(
                  child: TextField(
                    controller: searchController,
                    decoration: InputDecoration(
                      hintText: 'Search transactions...',
                      border: OutlineInputBorder(),
                      contentPadding: EdgeInsets.symmetric(vertical: 8.0, horizontal: 12.0), 
                    ),
                  ),
                ),
                SizedBox(width: 8.0),
                GestureDetector(
                  onTap: () {
                    String labNo = searchController.text.trim();
                    transactionListController.searchTransactions(labNo);
                  },
                  child: Container(
                    padding: EdgeInsets.symmetric(vertical: 10.0, horizontal: 16.0),
                    decoration: BoxDecoration(
                      color: Colors.blueGrey,
                      borderRadius: BorderRadius.circular(8.0),
                    ),
                    child: Center(
                      child: Text(
                        'Search',
                        style: TextStyle(color: Colors.white, fontSize: 14.0), 
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
      body: Obx(() {
        if (transactionListController.isLoading.value) {
          return Center(child: CircularProgressIndicator());
        }

        if (transactionListController.transactions.isEmpty) {
          return Center(child: Text('No transactions found.'));
        }

        return ListView.builder(
          itemCount: transactionListController.transactions.length,
          itemBuilder: (context, index) {
            var transaction = transactionListController.transactions[index];
            return Card(
              margin: EdgeInsets.symmetric(vertical: 8.0, horizontal: 16.0),
              child: InkWell(
                onTap: () {
                  String labNo = transaction['Lab_No'];
                  Get.toNamed('/transaction-detail', arguments: labNo);
                },
                child: Padding(
                  padding: const EdgeInsets.all(10.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Icon(Icons.article, color: Colors.black),
                          SizedBox(width: 10),
                          Expanded(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  '${transaction['name'] ?? 'N/A'}',
                                  style: TextStyle(fontWeight: FontWeight.bold),
                                ),
                                SizedBox(height: 4),
                                Text(
                                  'Unit No: ${transaction['UNIT_NO'] ?? 'N/A'} - Model: ${transaction['MODEL'] ?? 'N/A'}',
                                  overflow: TextOverflow.ellipsis,
                                ),
                                SizedBox(height: 4),
                                Text(
                                  'Component: ${transaction['COMPONENT'] ?? 'N/A'}',
                                  overflow: TextOverflow.ellipsis,
                                ),
                                Text('Sample date: ${transaction['SAMPL_DT1'] ?? 'N/A'}'),
                                Text('Report date: ${transaction['RPT_DT1'] ?? 'N/A'}'),
                                // SizedBox(height: 4),
                                // Row(
                                //   mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                //   children: [
                                //     Expanded(
                                //       child: Text(
                                //         'Sample date: ${transaction['SAMPL_DT1'] ?? 'N/A'}',
                                //         overflow: TextOverflow.ellipsis,
                                //       ),
                                //     ),
                                //     SizedBox(width: 10),
                                //     Expanded(
                                //       child: Text(
                                //         'Report date: ${transaction['RPT_DT1'] ?? 'N/A'}',
                                //         overflow: TextOverflow.ellipsis,
                                //       ),
                                //     ),
                                //   ],
                                // ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ),
            );
          },
        );
      }),
      bottomNavigationBar: BottomAppBar(
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 20, vertical: 10),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              IconButton(
                icon: Icon(Icons.home, color: Colors.black),
                onPressed: () {
                  Get.toNamed('/dashboard');
                },
              ),
              IconButton(
                icon: Icon(Icons.explore, color: Colors.black),
                onPressed: () {
                  Get.toNamed('/transaction-list');
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}
