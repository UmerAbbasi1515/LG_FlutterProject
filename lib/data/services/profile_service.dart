import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:localgovernment_project/data/helpers/base_client.dart';
import 'package:localgovernment_project/data/helpers/session_controller.dart';
import 'package:localgovernment_project/data/models/auth_models/validate_user_model.dart';
import 'package:localgovernment_project/data/models/common_response_model.dart';
import 'package:localgovernment_project/utils/constants/app_config.dart';
import 'package:localgovernment_project/utils/constants/meta_labels.dart';

class TenantProfileServices {
  static Future<dynamic> getProfile() async {
    var data = {};
    var url = AppConfig().getUserProfile;
    var response = await BaseClientClass.postwithheader(url ?? "", data,
        token: SessionController().getLoginToken());
    if (response is http.Response) {
      final jsonData = jsonDecode(response.body);
      final apiResponse = ApiResponse<UserModel>.fromJson(
        jsonData,
        (data) => UserModel.fromJson(data),
      );
      return apiResponse;
    }
    throw Exception(AppMetaLabels().invalidResponse);
  }

  static Future<dynamic> updateProfile(
      String name, String mobileNo, String email, String address) async {
    var data = {
      "userId": SessionController().getUser().id.toString(),
      "nameEn": name,
      "nameUr": name,
      "phone": mobileNo,
      "email": email,
      "address": address,
      "addressUr": address
    };
    var url = AppConfig().updateUserProfile;
    var response = await BaseClientClass.postwithheader(url ?? "", data,
        token: SessionController().getLoginToken());
    if (response is http.Response) {
      final jsonData = jsonDecode(response.body);
      final apiResponse = ApiResponse<CommonMessageModel>.fromJson(
        jsonData,
        (data) => CommonMessageModel.fromJson(data),
      );
      return apiResponse;
    }
    throw Exception(AppMetaLabels().invalidResponse);
  }
}
