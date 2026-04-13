import 'package:flutter/foundation.dart';
import 'package:get/get.dart';
import 'package:localgovernment_project/data/helpers/base_client.dart';
import 'package:localgovernment_project/data/helpers/session_controller.dart';
import 'package:localgovernment_project/data/models/auth_models/validate_user_model.dart';
import 'package:localgovernment_project/data/models/common_response_model.dart';
import 'package:localgovernment_project/data/repository/profile_repository.dart';
import 'package:localgovernment_project/utils/constants/meta_labels.dart';
import 'package:localgovernment_project/views/common/no_internet_screen.dart';
import 'package:localgovernment_project/views/widgets/snackbar_widget.dart';

class ProfileController extends GetxController {
  Rx<ApiResponse<UserModel>> model = ApiResponse<UserModel>().obs;
  var loadingData = true.obs;
  RxString error = "".obs;

  @override
  void onInit() {
    getProfile();
    super.onInit();
  }

  String getInitials(String fullName) {
    if (fullName.trim().isEmpty) return '';

    List<String> parts = fullName.trim().split(RegExp(r'\s+'));

    // If only one name → return first letter
    if (parts.length == 1) {
      return parts[0][0].toUpperCase();
    }

    // If multiple names → take first letter of each word
    String initials = parts.map((e) => e[0].toUpperCase()).join();

    return initials;
  }

  Future<void> getProfile() async {
    try {
      bool isInternetConnected = await BaseClientClass.isInternetConnected();
      if (!isInternetConnected) {
        await Get.to(() => const NoInternetScreen());
      }
      loadingData.value = true;
      var result = await ProfileRepository.getProfile();
      if (result is ApiResponse<UserModel>) {
        error.value = '';
        if (result.message == "user data found") {
          model.value = result;
          SessionController().nameEn = result.data?.nameEn;
          SessionController().nameUr = result.data?.nameUr;
        }
        update();
      } else {
        error.value = result;
      }
    } catch (e) {
      if (kDebugMode) {
        print('inside Catch $e}');
      }
      error.value = e.toString();
    } finally {
      loadingData.value = false;
    }
  }

  Future<void> updateProfile(String name, phone, email, address) async {
    try {
      bool isInternetConnected = await BaseClientClass.isInternetConnected();
      if (!isInternetConnected) {
        await Get.to(() => const NoInternetScreen());
      }
      loadingData.value = true;
      var result =
          await ProfileRepository.updateProfile(name, phone, email, address);
      if (result is ApiResponse<CommonMessageModel>) {
        error.value = '';
        if (result.message == "Success" &&
            result.data?.message == "Profile updated sucessfully") {
          SnakBarWidget.getSnackBarErrorBlue(
              AppMetaLabels().error, result.data?.message ?? "");
        }
        update();
      } else {
        SnakBarWidget.getSnackBarErrorBlue(
            AppMetaLabels().error, result.data?.message ?? "");
      }
    } catch (e) {
      if (kDebugMode) {
        print('inside Catch $e}');
      }
      SnakBarWidget.getSnackBarErrorBlue(AppMetaLabels().error, e.toString());
      error.value = e.toString();
    } finally {
      loadingData.value = false;
    }
  }
}
