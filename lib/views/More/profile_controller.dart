import 'package:flutter/foundation.dart';
import 'package:get/get.dart';
import 'package:localgovernment_project/data/helpers/base_client.dart';
import 'package:localgovernment_project/data/helpers/session_controller.dart';
import 'package:localgovernment_project/data/models/profile_model.dart';
import 'package:localgovernment_project/data/repository/profile_repository.dart';
import 'package:localgovernment_project/utils/constants/global_preferences.dart';
import 'package:localgovernment_project/utils/constants/meta_labels.dart';
import 'package:localgovernment_project/views/common/no_internet_screen.dart';

class TenantProfileController extends GetxController {
  var tenantProfile = TenantProfileModel().obs;
  var updateProfiledata = TenantUpdateProfileModel().obs;

  var loadingData = true.obs;
  RxString error = "".obs;
  var loadingUpdate = false.obs;
  RxString errorUpdate = "".obs;

  RxBool loadingCanEdit = true.obs;
  int? caseNo;

  @override
  void onInit() {
    getData();
    super.onInit();
  }

  getData() async {
    bool isInternetConnected = await BaseClientClass.isInternetConnected();
    if (!isInternetConnected) {
      await Get.to(const NoInternetScreen());
    }
    try {
      loadingData.value = true;
      var result = await ProfileRepository.tenantProfile();
      if (result is TenantProfileModel) {
        if (tenantProfile.value.status == AppMetaLabels().notFound) {
          error.value = AppMetaLabels().noDatafound;
          loadingData.value = false;
        } else {
          tenantProfile.value = result;
          // saveUserNameLocally(tenantProfile.value);
          update();
          loadingData.value = false;
        }
      } else {
        // error.value = AppMetaLabels().noDatafound;
        error.value = result;
        loadingData.value = false;
      }
    } catch (e) {
      loadingData.value = false;
      if (kDebugMode) {
        print("this is the error from controller= $e");
      }
    }
  }

  void saveUserNameLocally(TenantProfileModel tenantProfile) async {
    GlobalPreferencesEncrypted.setString(
      GlobalPreferencesLabels.userName,
      tenantProfile.profile!.name ?? "",
    );

    GlobalPreferencesEncrypted.setString(
      GlobalPreferencesLabels.userNameAr,
      tenantProfile.profile!.nameAr ?? "",
    );
  }

  Future<void> setUserName() async {
    String name = await GlobalPreferencesEncrypted.getString(
        GlobalPreferencesLabels.userName);
    String nameAr = await GlobalPreferencesEncrypted.getString(
        GlobalPreferencesLabels.userNameAr);
    if (SessionController().getLanguage() == 1) {
      SessionController().setUserName(name);
    } else {
      SessionController().setUserID(nameAr);
    }
  }

  Future<bool> updateProfile(
      String name, String mobileNo, String email, String address) async {
    bool isInternetConnected = await BaseClientClass.isInternetConnected();
    if (!isInternetConnected) {
      await Get.to(const NoInternetScreen());
    }
    try {
      loadingUpdate.value = true;
      var result =
          await ProfileRepository.updateProfile(name, mobileNo, email, address);

      loadingUpdate.value = false;
      if (result is TenantUpdateProfileModel) {
        if (result.status == "Ok") {
          updateProfiledata.value = result;
          caseNo = result.addServiceRequest!.caseNo;
          loadingCanEdit.value = true;
          loadingCanEdit.value = false;
          return true;
        } else {
          Get.snackbar(AppMetaLabels().error, result.message ?? "");
          return false;
        }
      } else {
        Get.snackbar(AppMetaLabels().error, AppMetaLabels().someThingWentWrong);
        errorUpdate.value = AppMetaLabels().noDatafound;
        return false;
      }
    } catch (e) {
      loadingUpdate.value = false;
      if (kDebugMode) {
        print("this is the error from controller= $e");
      }
      return false;
    }
  }
}
