import 'package:get/get.dart';
import '../views/login_page.dart';
import '../views/dashboard_page.dart';
import '../views/transaction_list_page.dart';
import '../views/transaction_detail_page.dart';
import '../views/pdf_viewer_page.dart';

part 'app_routes.dart';

class AppPages {
  static const INITIAL = Routes.LOGIN;

  static final routes = [
    GetPage(name: Routes.LOGIN, page: () => LoginPage()),
    GetPage(name: Routes.DASHBOARD, page: () => DashboardPage()),
    GetPage(name: Routes.TRANSACTION_LIST, page: () => TransactionListPage()),
    GetPage(name: Routes.TRANSACTION_DETAIL, page: () => TransactionDetailPage()),
    GetPage(name: Routes.PDF_VIEWER, page: () => PdfViewerPage()),
  ];
}
