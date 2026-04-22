import 'package:flutter/widgets.dart';
import 'package:get/get.dart';
import 'package:localgovernment_project/data/helpers/base_client.dart';
import 'package:localgovernment_project/data/helpers/session_controller.dart';
import 'package:localgovernment_project/data/models/auth_models/validate_user_model.dart';
import 'package:localgovernment_project/data/models/common_response_model.dart';
import 'package:localgovernment_project/data/repository/auth_repository.dart';
import 'package:localgovernment_project/utils/constants/global_preferences.dart';
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
      error.value = AppMetaLabels().confirmPasswordRequired;
    } else if (confirmPassword.value != password.value) {
      error.value = AppMetaLabels().passwordDoNotMatch;
    } else {
      error.value = "";
    }
  }

  String maskPhoneNumber(String phone) {
    if (phone.isEmpty || phone.length < 7) {
      return phone;
    }

    String start = phone.substring(0, 4); // +923
    String end = phone.substring(phone.length - 3); // 083

    return "$start****$end";
  }

  var passwordSetModel = ApiResponse<CommonMessageModel>().obs;
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
      if (result is ApiResponse<CommonMessageModel>) {
        passwordSetModel.value = result;

        if (passwordSetModel.value.message == "Password update successfull" &&
            passwordSetModel.value.data?.message ==
                "Password update successfully") {
          Get.offAll(() => ValidateUserScreen());
        } else {
          SnakBarWidget.getSnackBarErrorBlue(
              AppMetaLabels().error,
              SessionController().getLanguage() == 1
                  ? passwordSetModel.value.message ?? ""
                  : passwordSetModel.value.messageUr ?? "");
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
        if (loginWithPassModel.value.data != null &&
            loginWithPassModel.value.message !=
                "Token generation failed,Please try again later / contact with support team") {
          ////////////////////////////
          /// SessionController ///
          ////////////////////////////
          SessionController().setUser(loginWithPassModel.value.data?.user);
          SessionController()
              .setLoginToken(loginWithPassModel.value.data?.token);
          SessionController().setToken(loginWithPassModel.value.data?.token);
          var phone = SessionController().getPhone();

          /////////////////////////////////////
          /// GlobalPreferencesEncrypted ///
          ////////////////////////////////////
          saveDataLocally();
          SessionController().setPhone(phone);
          if (loginWithPassModel.value.message != "user not found" &&
              loginWithPassModel.value.data != null) {
            Get.offAll(() => TenantDashboardTabs());
          } else {
            SnakBarWidget.getSnackBarErrorBlue(
                AppMetaLabels().error,
                SessionController().getLanguage() == 1
                    ? loginWithPassModel.value.message ?? ""
                    : loginWithPassModel.value.messageUr ?? "");
          }
          isLoading.value = false;
        } else {
          isLoading.value = false;
          SnakBarWidget.getSnackBarErrorBlue(
              AppMetaLabels().error,
              SessionController().getLanguage() == 1
                  ? loginWithPassModel.value.message ?? ""
                  : loginWithPassModel.value.messageUr ?? "");
        }
      } else {
        errorWhileApiCall.value = result;
        isLoading.value = false;
        SnakBarWidget.getSnackBarErrorBlue(
            AppMetaLabels().error,
            SessionController().getLanguage() == 1
                ? loginWithPassModel.value.message ?? ""
                : loginWithPassModel.value.messageUr ?? "");
      }
    } catch (e) {
      isLoading.value = false;
      SnakBarWidget.getSnackBarErrorBlue(
          AppMetaLabels().error,
          SessionController().getLanguage() == 1
              ? loginWithPassModel.value.message ?? ""
              : loginWithPassModel.value.messageUr ?? "");
    }
  }

  void saveDataLocally() async {
    var phone = SessionController().getPhone();
    GlobalPreferencesEncrypted.setString(
      GlobalPreferencesLabels.phoneNumber,
      phone ?? "",
    );

    GlobalPreferencesEncrypted.setString(
      GlobalPreferencesLabels.loginToken,
      loginWithPassModel.value.data?.token ?? "",
    );

    GlobalPreferencesEncrypted.setString(
      GlobalPreferencesLabels.userName,
      loginWithPassModel.value.data?.user.nameEn ?? "",
    );

    GlobalPreferencesEncrypted.setString(
      GlobalPreferencesLabels.userNameAr,
      loginWithPassModel.value.data?.user.nameUr ?? "",
    );

    GlobalPreferencesEncrypted.setString(
      GlobalPreferencesLabels.userID,
      loginWithPassModel.value.data?.user.id.toString() ?? "",
    );

    GlobalPreferences.setbool(
      GlobalPreferencesLabels.isLoginBool,
      true,
    );
    GlobalPreferences.setbool(
      GlobalPreferencesLabels.isPasswordSet,
      true,
    );
  }
}
