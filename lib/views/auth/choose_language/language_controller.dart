
import 'package:flutter/foundation.dart';
import 'package:get/get.dart';
import 'package:localgovernment_project/data/helpers/base_client.dart';
import 'package:localgovernment_project/data/helpers/session_controller.dart';
import 'package:localgovernment_project/data/models/auth_models/languae_model.dart';
import 'package:localgovernment_project/data/models/common_response_model.dart';
import 'package:localgovernment_project/utils/constants/app_config.dart';
import 'package:localgovernment_project/utils/constants/global_preferences.dart';
import 'package:localgovernment_project/views/auth/auth_flow/validate_user.dart';
import 'package:localgovernment_project/views/auth/splash_screen/splash_screen.dart';
import 'package:localgovernment_project/views/common/no_internet_screen.dart';

import '../../../data/repository/auth_repository.dart';

class LanguageController extends GetxController {
  Rx<ApiResponse<List<Language>>> model = ApiResponse<List<Language>>(data: []).obs;
  var loadingData = false.obs;
  RxString error = "".obs;
  RxInt selectedLang = 1.obs;
  RxBool isLoginBool = false.obs;
  bool _langSelected = false;


  @override
  void onInit() {
    getData();
    super.onInit();
  }

  Future<void> getData() async {
    try {
      isLoginBool.value =
          await GlobalPreferences.getBool(GlobalPreferencesLabels.isLoginBool);
      bool isInternetConnected = await BaseClientClass.isInternetConnected();
      if (!isInternetConnected) {
        await Get.to(() => const NoInternetScreen());
      }
      loadingData.value = true;
      var result = await CommonRepository.getLanguage();
      loadingData.value = false;
      if (result is ApiResponse<List<Language>>) {
        error.value = '';
        _langSelected = true;
        model.value = result;
        update();
      } else {
        error.value = result;
      }
    } catch (e) {
      if (kDebugMode) {
        print('inside Catch $e}');
      }
    }finally{
      loadingData.value = false;
    }
  }

  void changeLanguage(int langId, bool isLoggedIn, bool cont) async {
    _langSelected = true;
    loadingData.value = true;
    selectedLang.value = langId;
    SessionController().setLanguage(selectedLang.value);
    GlobalPreferences.setbool(GlobalPreferencesLabels.setLanguage, true);
    int prevLang =
        await GlobalPreferences.getInt(GlobalPreferencesLabels.langId) ?? 1;
    GlobalPreferences.setInt(GlobalPreferencesLabels.langId, langId);
    if (langId == 1) {
      GlobalPreferences.setbool(GlobalPreferencesLabels.isEnglish, true);
    } else {
      GlobalPreferences.setbool(GlobalPreferencesLabels.isEnglish, false);
    }

    if (!isLoggedIn) {
      Get.offAll(() => ValidateUserScreen());
    } else if (!cont && prevLang != langId) {
      await updateLang();
      Get.snackbar("Login", "Go to Dashboard");
    }
    loadingData.value = false;
  }

  Future updateLang() async {
    var data = {"LangId": SessionController().getLanguage()};
    await BaseClientClass.postwithheader(AppConfig().updateLanguage!, data);
  }

  Future<void> countinueBtn() async {
    var isSelect =
        await GlobalPreferences.getBool(GlobalPreferencesLabels.setLanguage);
    if (!isSelect) {
      SessionController().setLanguage(1);
      GlobalPreferences.setbool(GlobalPreferencesLabels.isEnglish, true);
      return;
    }
    SessionController().setLanguage(selectedLang.value);
    if (_langSelected) {
      GlobalPreferences.setbool(GlobalPreferencesLabels.setLanguage, true);
      GlobalPreferences.setInt(
          GlobalPreferencesLabels.langId, selectedLang.value);
      if (selectedLang.value == 1) {
        GlobalPreferences.setbool(GlobalPreferencesLabels.isEnglish, true);
      } else {
        GlobalPreferences.setbool(GlobalPreferencesLabels.isEnglish, false);
      }
    }
    isLoginBool.value == true
        ? Get.to(() => const SplashScreen())
        : Get.to(() => const ValidateUserScreen());
  }


  Future<void> updateData(langId) async {
    bool isInternetConnected = await BaseClientClass.isInternetConnected();
    if (!isInternetConnected) {
      await Get.to(() => const NoInternetScreen());
    }
    loadingData.value = true;
    var result = await CommonRepository.updateLanguage(langId);
    loadingData.value = false;
    if (result is ApiResponse<dynamic>) {
      Get.snackbar(result.statusCode.toString(),result.message??"");
      update();
    } else {
      error.value = result;
    }
  }
}
