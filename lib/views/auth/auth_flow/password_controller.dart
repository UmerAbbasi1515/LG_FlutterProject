import 'package:flutter/widgets.dart';
import 'package:get/get.dart';
import 'package:localgovernment_project/data/helpers/base_client.dart';
import 'package:localgovernment_project/data/helpers/session_controller.dart';
import 'package:localgovernment_project/data/models/auth_models/validate_user_model.dart';
import 'package:localgovernment_project/data/models/common_response_model.dart';
import 'package:localgovernment_project/data/repository/auth_repository.dart';
import 'package:localgovernment_project/utils/constants/meta_labels.dart';
import 'package:localgovernment_project/views/Dashboard/dashboard_tabs/dashboard_tabs_screen.dart';
import 'package:localgovernment_project/views/auth/auth_flow/validate_user.dart';
import 'package:localgovernment_project/views/common/no_internet_screen.dart';
import 'package:localgovernment_project/views/widgets/snackbar_widget.dart';

class PasswordController extends GetxController {
  final TextEditingController passwordController = TextEditingController();
  final TextEditingController confirmPasswordController =
      TextEditingController();
  var isLoading = false.obs;
  var errorWhileApiCall = ''.obs;
  var password = ''.obs;
  var confirmPassword = ''.obs;
  var error = ''.obs;
  var tempVariable = ''.obs;

  var obscurePassword = true.obs;
  var obscureConfirm = true.obs;

  // Rules
  bool hasMinLength(String val) => val.length >= 8;
  bool hasUpperCase(String val) => RegExp(r'[A-Z]').hasMatch(val);
  bool hasLowerCase(String val) => RegExp(r'[a-z]').hasMatch(val);
  bool hasDigit(String val) => RegExp(r'\d').hasMatch(val);
  bool hasSpecialChar(String val) => RegExp(r'[@$!%*?&]').hasMatch(val);

  bool passwordsMatch() => password.value == confirmPassword.value;

  void validateConfirmPassword() {
    if (confirmPassword.value.isEmpty) {
      error.value = "Confirm password required";
    } else if (confirmPassword.value != password.value) {
      error.value = "Passwords do not match";
    } else {
      error.value = "";
    }
  }

  var passwordSetModel = ApiResponse<PasswordSetData>().obs;
  Future<void> setPassword() async {
    bool isInternetConnected = await BaseClientClass.isInternetConnected();
    if (!isInternetConnected) {
      Get.to(() => const NoInternetScreen());
    }
    errorWhileApiCall.value = '';
    try {
      isLoading.value = true;
      var mobile = SessionController().getPhone();
      var result =
          await CommonRepository.setPassword(mobile, passwordController.text);
      if (result is ApiResponse<PasswordSetData>) {
        passwordSetModel.value = result;

        if (passwordSetModel.value.message != "Password Success" &&
            passwordSetModel.value.data?.password !=
                "Password set successfully") {
          Get.offAll(() => ValidateUserScreen());
        } else {
          SnakBarWidget.getSnackBarErrorBlue(
              AppMetaLabels().error, passwordSetModel.value.message ?? "");
        }
        isLoading.value = false;
      } else {
        errorWhileApiCall.value = result;
        isLoading.value = false;
      }
    } catch (e) {
      isLoading.value = false;
    }
  }

  var loginWithPassModel = ApiResponse<OtpData>().obs;
  Future<void> loginWithPassword() async {
    bool isInternetConnected = await BaseClientClass.isInternetConnected();
    if (!isInternetConnected) {
      Get.to(() => const NoInternetScreen());
    }
    errorWhileApiCall.value = '';
    try {
      isLoading.value = true;
      var mobile = SessionController().getPhone();
      var result = await CommonRepository.loginWithPassword(
          mobile, passwordController.text);
      if (result is ApiResponse<OtpData>) {
        loginWithPassModel.value = result;
        if (loginWithPassModel.value.message != "user not found" &&
            loginWithPassModel.value.data != null) {
          Get.offAll(() => TenantDashboardTabs());
        } else {
          SnakBarWidget.getSnackBarErrorBlue(
              AppMetaLabels().error, loginWithPassModel.value.message ?? "");
        }
        isLoading.value = false;
      } else {
        errorWhileApiCall.value = result;
        isLoading.value = false;
      }
    } catch (e) {
      isLoading.value = false;
    }
  }
}
