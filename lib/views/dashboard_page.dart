import 'package:coba_test/controllers/auth_controller.dart';
import 'package:coba_test/controllers/dashboard_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:syncfusion_flutter_charts/charts.dart';

class DashboardPage extends StatefulWidget {
  @override
  _DashboardPageState createState() => _DashboardPageState();
}

class _DashboardPageState extends State<DashboardPage> {
  final AuthController authController = Get.find<AuthController>();
  final DashboardController dashboardController = Get.put(DashboardController());

  @override
  void initState() {
    super.initState();
    dashboardController.fetchDashboardData('RMLTRK');
  }
@override
Widget build(BuildContext context) {
  return Scaffold(
    appBar: AppBar(
      title: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Expanded(child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Obx(
                () => Text(
                  'Welcome ${authController.username.value}',
                  style: TextStyle(fontWeight: FontWeight.bold),
                ),
              ),
              Text(
                'PT Riung Mitra Lestari HO',
                style: TextStyle(fontSize: 12),
              ),
            ],
          )),
          IconButton(
            onPressed: () {
              authController.logout();
            },
            icon: Icon(Icons.logout, color: Colors.redAccent[700]),
          ),
        ],
      ),
      automaticallyImplyLeading: false,
    ),
    body: SingleChildScrollView(
      child: Obx(() {
        final List<ChartData> chartData = [
          ChartData('Normal', double.parse(dashboardController.totalNormal.value), Colors.green[900]),
          ChartData('Caution', double.parse(dashboardController.totalCaution.value), Colors.yellow[400]),
          ChartData('Critical', double.parse(dashboardController.totalCritical.value), Colors.red[400]),
          ChartData('Severe', double.parse(dashboardController.totalSevere.value), Colors.black),
        ];

        return Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Center(
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    SizedBox(height: 25),
                    Text(
                      'Used Oil Unit Status Summary',
                      style: TextStyle(fontSize: 15, fontWeight: FontWeight.bold),
                    ),
                    Text(
                      '(In 2 Mounts)',
                      style: TextStyle(fontSize: 14, color: Colors.grey[700], fontStyle: FontStyle.italic),
                    ),
                    Container(
                      padding: EdgeInsets.all(1),
                      child: SfCircularChart(
                        series: <CircularSeries>[
                          DoughnutSeries<ChartData, String>(
                            dataSource: chartData,
                            pointColorMapper: (ChartData data, _) => data.color,
                            xValueMapper: (ChartData data, _) => data.x,
                            yValueMapper: (ChartData data, _) => data.y,
                            dataLabelMapper: (ChartData data, _) =>
                                '${data.x}: ${data.y.toStringAsFixed(1)} (${(data.y / _totalValue(chartData) * 100).toStringAsFixed(1)}%)',
                            dataLabelSettings: DataLabelSettings(
                              isVisible: true,
                              textStyle: TextStyle(fontSize: 12),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    "Categories",
                    style: TextStyle(fontSize: 15, fontWeight: FontWeight.bold),
                  ),
                  SizedBox(height: 10),
                  Container(
                    color: Colors.grey,
                    padding: EdgeInsets.all(8.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          children: [
                            Icon(Icons.deblur, color: Colors.white),
                            SizedBox(width: 8),
                            Text('UT PAP 4.0', style: TextStyle(color: Colors.white)),
                          ],
                        ),
                        SizedBox(height: 10),
                        SizedBox(height: 10),
                        Text('Used Oil Transaction list', style: TextStyle(color: Colors.white)),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ],
        );
      }),
    ),
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
  double _totalValue(List<ChartData> chartData) {
    return chartData.fold(0, (sum, data) => sum + data.y);
  }
}

class ChartData {
  ChartData(this.x, this.y, [this.color]);
  final String x;
  final double y;
  final Color? color;
}
