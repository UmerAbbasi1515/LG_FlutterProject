import 'dart:async';
import 'package:get/get.dart';
import 'package:localgovernment_project/utils/constants/global_preferences.dart';
import 'package:localgovernment_project/views/auth/auth_flow/validate_user.dart';

class BlockedDeviceController extends GetxController {
  @override
  void onInit() {
    getPrefsData();
    setTimer();
    super.onInit();
  }

  int blockTime = 0;
  bool isBlocked = false;
  RxString secText = "".obs;

  Future<void> getPrefsData() async {
    blockTime =
        await GlobalPreferences.getInt(GlobalPreferencesLabels.blockTime);
    isBlocked =
        await GlobalPreferences.getBool(GlobalPreferencesLabels.isBlocked);
  }

  void setTimer() {
    Timer.periodic(const Duration(seconds: 1), (timer) {
      if (blockTime >= 2) {
        blockTime = blockTime - 1;
        GlobalPreferences.setInt(GlobalPreferencesLabels.blockTime, blockTime);
        secText.value = blockTime.toString();
      } else {
        timer.cancel();
        Get.offAll(() => const ValidateUserScreen());
        // : Get.offAll(() => ValidateUserArabicScreen());
        GlobalPreferencesEncrypted.clearValues();
        GlobalPreferences.setClear();
        GlobalPreferences.setbool(GlobalPreferencesLabels.isBlocked, false);
      }
    });
  }
}
