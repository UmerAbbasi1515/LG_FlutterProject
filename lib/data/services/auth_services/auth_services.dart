import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:localgovernment_project/data/helpers/base_client.dart';
import 'package:localgovernment_project/data/helpers/session_controller.dart';
import 'package:localgovernment_project/data/models/auth_models/validate_user_model.dart';
import 'package:localgovernment_project/data/models/common_response_model.dart';
import 'package:localgovernment_project/utils/constants/app_config.dart';
import 'package:localgovernment_project/utils/constants/meta_labels.dart';

class AuthServices {
  static Future<dynamic> validateUser() async {
    var data = {
      "mobile": SessionController().getPhone(),
    };
    var url = AppConfig().validateUser;
    var response = await BaseClientClass.postwithheader(url ?? "", data,
        token: SessionController().getLoginToken());
    if (response is http.Response) {
      final jsonData = jsonDecode(response.body);

      if (jsonData is Map<String, dynamic> && jsonData['data'] != null) {
        return ApiResponse<ValidateUserModel>.fromJson(
          jsonData,
          (data) => ValidateUserModel.fromJson(data),
        );
      } else {
        return ApiResponse<ValidateUserModel>(
          data: null,
          message: jsonData['message']?.toString() ?? "Invalid response",
          statusCode: jsonData['statusCode'],
        );
      }
    }
    throw Exception(AppMetaLabels().invalidResponse);
  }

  static Future<dynamic> verfiyUserOTP(
      String? otp, String? otpCodeForVerifyOTP, String? status) async {
    var data = {
      "mobile": SessionController().getPhone(),
      "otpCode": otpCodeForVerifyOTP,
      "otp": otp,
      "otpVerifyStatus": status
    };
    var url = AppConfig().verifyUserOTP;
    var response = await BaseClientClass.postwithheader(url ?? "", data,
        token: SessionController().getLoginToken());
    if (response is http.Response) {
      final jsonData = jsonDecode(response.body);

      if (jsonData is Map<String, dynamic> && jsonData['data'] != null) {
        return ApiResponse<CommonMessageModel>.fromJson(
          jsonData,
          (data) => CommonMessageModel.fromJson(data),
        );
      } else {
        return ApiResponse<CommonMessageModel>(
          data: null,
          message: jsonData['message']?.toString() ?? "Invalid response",
          statusCode: jsonData['statusCode'],
        );
      }
    }
    throw Exception(AppMetaLabels().invalidResponse);
  }

  static Future<dynamic> setPassword(String? mobile, String? password) async {
    var data = {
      "mobile": SessionController().getPhone(),
      "password": password,
    };
    var url = AppConfig().setPassword;
    var response = await BaseClientClass.postwithheader(url ?? "", data,
        token: SessionController().getLoginToken());
    if (response is http.Response) {
      final jsonData = jsonDecode(response.body);

      if (jsonData is Map<String, dynamic> && jsonData['data'] != null) {
        return ApiResponse<CommonMessageModel>.fromJson(
          jsonData,
          (data) => CommonMessageModel.fromJson(data),
        );
      } else {
        return ApiResponse<CommonMessageModel>(
          data: null,
          message: jsonData['message']?.toString() ?? "Invalid response",
          statusCode: jsonData['statusCode'],
        );
      }
    }
    throw Exception(AppMetaLabels().invalidResponse);
  }

  static Future<dynamic> loginWithPassword(
      String? mobile, String? password) async {
    var data = {
      "mobile": mobile,
      "password": password,
    };
    var url = AppConfig().loginWithPassword;
    var response = await BaseClientClass.postwithheader(url ?? "", data,
        token: SessionController().getLoginToken());
    if (response is http.Response) {
      final jsonData = jsonDecode(response.body);
      if (jsonData is Map<String, dynamic> && jsonData['data'] != null) {
        return ApiResponse<OtpData>.fromJson(
          jsonData,
          (data) => OtpData.fromJson(data),
        );
      } else {
        return ApiResponse<OtpData>(
          data: null,
          message: jsonData['message']?.toString() ?? "Invalid response",
          statusCode: jsonData['statusCode'],
        );
      }
    }
    throw Exception(AppMetaLabels().invalidResponse);
  }
}
