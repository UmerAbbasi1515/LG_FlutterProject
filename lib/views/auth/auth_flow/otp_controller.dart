// ignore_for_file: prefer_typing_uninitialized_variables

import 'dart:async';
import 'dart:io';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:localgovernment_project/data/helpers/base_client.dart';
import 'package:localgovernment_project/data/helpers/session_controller.dart';
import 'package:localgovernment_project/data/models/auth_models/validate_user_model.dart';
import 'package:localgovernment_project/data/models/common_response_model.dart';
import 'package:localgovernment_project/data/repository/auth_repository.dart';
import 'package:localgovernment_project/utils/constants/app_const.dart';
import 'package:localgovernment_project/utils/constants/global_preferences.dart';
import 'package:localgovernment_project/utils/constants/meta_labels.dart';
import 'package:localgovernment_project/utils/styles/colors.dart';
import 'package:localgovernment_project/views/Dashboard/dashboard_tabs/dashboard_tabs_screen.dart';
import 'package:localgovernment_project/views/auth/auth_flow/validate_user_controller.dart';
import 'package:localgovernment_project/views/auth/blocked_device/block_device_screen.dart';
import 'package:localgovernment_project/views/common/no_internet_screen.dart';

class OTPController extends GetxController {
  var model = ApiResponse<OtpData>().obs;
  var validateUserModel = ApiResponse<OtpData>().obs;
  RxBool validOTP = true.obs;
  RxBool hasError = false.obs;
  RxBool loadingData = false.obs;
  RxBool pinFieldTap = false.obs;
  Color? changeColor;
  String? userMpin;
  String? phoneNo;
  String? statusCode;
  String? deviceName;
  String? deviceToken;
  String? deviceType;
  RxString error = "".obs;
  RxBool resending = false.obs;
  RxInt resendCounter = 0.obs;
  RxInt otpAttemptsCounter = 0.obs;

  @override
  void onInit() {
    // _getDeviceTokken();
    _getDeviceDetails();
    otpAttemptsCounter.value = 0;
    resendCounter.value = 0;
    validOTP.value = true;
    super.onInit();
  }

  Future<void> verifyOtpBtn(
      String otp, String otpCodeForVerifyOTP, String status) async {
    loadingData.value = true;
    bool isInternetConnected = await BaseClientClass.isInternetConnected();
    if (!isInternetConnected) {
      Get.to(() => const NoInternetScreen());
    }
    var result =
        await CommonRepository.verifyOtp(otp, otpCodeForVerifyOTP, status);
    if (result is ApiResponse<OtpData>) {
      model.value = result;

      if (model.value.message != "user verification failed" &&
          model.value.data?.user != null) {
        validOTP.value = true;
        changeColor = AppColors.whiteColor;

        ////////////////////////////
        /// SessionController ///
        ////////////////////////////
        SessionController().setUser(model.value.data?.user);
        SessionController().setLoginToken(model.value.data?.token);
        SessionController().setToken(model.value.data?.token);
        var phone = SessionController().getPhone();
        SessionController().setPhone(phone);

        /////////////////////////////////////
        /// GlobalPreferencesEncrypted ///
        ////////////////////////////////////
        saveDataLocally();
        Get.off(() => TenantDashboardTabs());
      }else{
        ValidateFirebaseUserController controller = Get.put(ValidateFirebaseUserController());
        controller.error.value = AppMetaLabels().incorrectCode;
      }
    } else {
      validOTP.value = false;
      changeColor = AppColors.redColor;
      error.value = AppMetaLabels().noDatafound;
      loadingData.value = false;
      otpAttemptsCounter.value++;
      if (otpAttemptsCounter.value >= 5) {
        Get.offAll(() => BlockedDeviceScreen());
        GlobalPreferences.setInt(
            GlobalPreferencesLabels.blockTime, AppConst.blockTime);
        GlobalPreferences.setbool(GlobalPreferencesLabels.isBlocked, true);
      }
    }
    loadingData.value = false;
  }

  void saveDataLocally() async {
    var phone = SessionController().getPhone();
    GlobalPreferencesEncrypted.setString(
      GlobalPreferencesLabels.phoneNumber,
      phone ?? "",
    );

    GlobalPreferencesEncrypted.setString(
      GlobalPreferencesLabels.loginToken,
      model.value.data?.token ?? "",
    );

    GlobalPreferencesEncrypted.setString(
      GlobalPreferencesLabels.userName,
      model.value.data?.user.nameEn ?? "",
    );

    GlobalPreferencesEncrypted.setString(
      GlobalPreferencesLabels.userNameAr,
      model.value.data?.user.nameUr ?? "",
    );

    GlobalPreferencesEncrypted.setString(
      GlobalPreferencesLabels.userID,
      model.value.data?.user.id.toString() ?? "",
    );

    GlobalPreferences.setbool(
      GlobalPreferencesLabels.isLoginBool,
      true,
    );
  }

  //////////////////////////////////////////
  /////   _getDeviceDetails
  //////////////////////////////////////////
  _getDeviceDetails() async {
    if (Platform.isAndroid) {
      deviceType = "Android";
      deviceName = "Android";
    } else if (Platform.isIOS) {
      deviceType = "IOS";
      deviceName = "IOS";
    }
  }
  //////////////////////////////////////////
  /////   getDeviceTokken
  //////////////////////////////////////////

  Future<void> getDeviceTokken() async {
    FirebaseMessaging.instance.requestPermission();
    if (defaultTargetPlatform == TargetPlatform.iOS) {
      if (kDebugMode == false) {
        await FirebaseMessaging.instance.getAPNSToken().then(
          (String? token) {
            assert(token != null);
            deviceToken = token;
            SessionController().setDeviceTokken(deviceToken);
            GlobalPreferencesEncrypted.setString(
                GlobalPreferencesLabels.deviceToken, deviceToken ?? "");
          },
        );
      } else {
        await FirebaseMessaging.instance.getToken().then(
          (String? token) {
            assert(token != null);
            deviceToken = token;
            SessionController().setDeviceTokken(deviceToken);
            GlobalPreferencesEncrypted.setString(
                GlobalPreferencesLabels.deviceToken, deviceToken ?? "");
          },
        );
      }
    } else {
      FirebaseMessaging.instance.getToken().then((String? token) {
        if (kDebugMode) {
          print("FCM Token: $token");
        }
      });
    }
  }
}
