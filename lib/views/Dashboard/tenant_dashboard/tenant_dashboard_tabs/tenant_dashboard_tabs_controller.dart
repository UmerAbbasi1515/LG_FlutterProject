import 'package:get/get.dart';
import '../tenant_dashboard_get_data_controller.dart';

class TenantDashboardTabsController extends GetxController {
  RxInt selectedIndex = 0.obs;
  @override
  void onInit() {
    Get.lazyPut(() => TenantDashboardGetDataController());
    super.onInit();
  }

  void setIndex(int index) {
    selectedIndex.value = index;
  }
}
