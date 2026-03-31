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
    var response = await BaseClientClass.postwithheader(url??"", data,
        token: SessionController().getLoginToken());
      if (response is http.Response) {
        final jsonData = jsonDecode(response.body);

        // ✅ Safe null check
        if (jsonData['data'] != null) {
          return ApiResponse<LoginData>.fromJson(
            jsonData,
            (data) => LoginData.fromJson(data),
          );
        } else {
          // ✅ Return empty response instead of throwing
          return ApiResponse<LoginData>(
            data: null,
            message: jsonData['message'],
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
    var response = await BaseClientClass.postwithheader(url??"", data,
        token: SessionController().getLoginToken());
     if (response is http.Response) {
      final jsonData = jsonDecode(response.body);
      final apiResponse = ApiResponse<OtpData>.fromJson(
          jsonData,
          (data) => OtpData.fromJson(data),
        );
      return apiResponse;
    }
      throw Exception(AppMetaLabels().invalidResponse);
  }
}
