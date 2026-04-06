import 'package:get/get.dart';
import 'package:flutter/foundation.dart';
import 'package:localgovernment_project/data/helpers/session_controller.dart';
import 'package:localgovernment_project/utils/constants/global_preferences.dart';
import 'package:localgovernment_project/views/auth/blocked_device/block_device_screen.dart';
import 'package:localgovernment_project/views/auth/choose_language/language_screen.dart';
import 'package:localgovernment_project/views/auth/auth_flow/validate_user.dart';

class SplashScreenController extends GetxController {
  bool isLoginBool = false;
  bool isBlocked = false;
  RxString secText = "".obs;
  RxString phone = "".obs;
  bool setLanguage = false;
  bool? isEnglish;


  @override
  void onInit() async {
    await prefsData();
    super.onInit();
  }

  prefsData() async {
    await setUserName();
    await getfp();
    await setUserMobile();
    isBlocked =
        await GlobalPreferences.getBool(GlobalPreferencesLabels.isBlocked) ??
            false;
    setLanguage =
        await GlobalPreferences.getBool(GlobalPreferencesLabels.setLanguage) ??
            false;
    if (kDebugMode) {
      print('Selected Language : $setLanguage');
    }
    String logintoken = await GlobalPreferencesEncrypted.getString(
        GlobalPreferencesLabels.loginToken);
    SessionController().setLoginToken(logintoken);
    if (!setLanguage) {
      SessionController().setLanguage(1);
      GlobalPreferences.setbool(GlobalPreferencesLabels.isEnglish, true);
    }
    isLoginBool =
        await GlobalPreferences.getBool(GlobalPreferencesLabels.isLoginBool) ??
            false;
    isEnglish =
        await GlobalPreferences.getBool(GlobalPreferencesLabels.isEnglish) ??
            true;
    SessionController().setLanguage(isEnglish! ? 1 : 2);

    phone.value = await GlobalPreferencesEncrypted.getString(
        GlobalPreferencesLabels.phoneNumber);

    Future.delayed(const Duration(seconds: kDebugMode ? 0 : 7), () async {
      if (isBlocked) {
        Get.to(() => BlockedDeviceScreen());
      } else {
        //  if (!setLanguage) {
        if (setLanguage) {
          await Get.to(() => const LanguageScreen(
                cont: true,
                loggedIn: false,
              ));
        }
        // Changed here must update *********>
        // if (isLoginBool) {
        //   Get.snackbar("Success", "Login successfully go to dashboard");
        // } else {
        //   Get.to(() => ValidateUserScreen());
        // }
       await Future.delayed(Duration(seconds: 2));
        Get.to(() => ValidateUserScreen());
      }
    });
  }

  Future<void> setUserName() async {
    String name = await GlobalPreferencesEncrypted.getString(
        GlobalPreferencesLabels.userName);
    String nameAr = await GlobalPreferencesEncrypted.getString(
        GlobalPreferencesLabels.userNameAr);

    String userName = "";
    if (SessionController().getLanguage() == 1) {
      userName = name;
    } else {
      userName = nameAr;
    }
    SessionController().setUserName(userName);
  }

  Future<void> setUserMobile() async {
    String phone = await GlobalPreferencesEncrypted.getString(
        GlobalPreferencesLabels.phoneNumber);
    SessionController().setPhone(phone);
  }

  getfp() async {
    bool fp =
        await GlobalPreferences.getBool(GlobalPreferencesLabels.fingerPrint);
    SessionController().setfingerprint(fp);
  }
}
