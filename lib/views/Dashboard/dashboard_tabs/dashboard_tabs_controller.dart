import 'package:get/get.dart';
import 'package:localgovernment_project/views/Dashboard/Project/project_controller.dart';

class TenantDashboardTabsController extends GetxController {
  RxInt selectedIndex = 0.obs;
  @override
  void onInit() {
    Get.lazyPut(() => ProjectController());
    super.onInit();
  }

  void setIndex(int index) {
    selectedIndex.value = index;
  }
}
