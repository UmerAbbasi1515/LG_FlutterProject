import 'dart:convert';
import 'package:flutter/foundation.dart';
import 'package:http/http.dart' as http;
import 'package:localgovernment_project/data/helpers/base_client.dart';
import 'package:localgovernment_project/data/helpers/session_controller.dart';
import 'package:localgovernment_project/data/models/auth_models/languae_model.dart';
import 'package:localgovernment_project/data/models/common_response_model.dart';
import 'package:localgovernment_project/utils/constants/app_config.dart';
import 'package:localgovernment_project/utils/constants/meta_labels.dart';

class UserLanguageServices {
  static Future<dynamic> getlanguage() async {
    var url = AppConfig().getLanguage;
    if (kDebugMode) {
      print(url);
    }
    var data = {};

    var response = await BaseClientClass.postwithheader(url ?? "", data);

    if (response is http.Response) {
      final jsonData = jsonDecode(response.body);
      
  final apiResponse = ApiResponse<List<Language>>.fromJson(
    jsonData,
    (data) {
      if (data == null) return [];

      final list = data is List ? data : data['data'];

      if (list == null) return [];

      return (list as List)
          .map((e) => Language.fromJson(e))
          .toList();
    },
  );
      return apiResponse;
    }
    throw Exception(AppMetaLabels().invalidResponse);
  }

  static Future<dynamic> updateLanguage(langId) async {
    var url = AppConfig().updateLanguage;

    var data = {
      "Mobile": SessionController().getPhone(),
      "LangId": langId.toString(),
    };

    var response = await BaseClientClass.postwithheader(url ?? "", data,
        token: SessionController().getLoginToken());

    if (response is http.Response) {
      final jsonData = jsonDecode(response.body);
      final apiResponse = ApiResponse<dynamic>.fromJson(
        jsonData,
        (data) => data,
      );
      return apiResponse;
    }
    throw Exception(AppMetaLabels().invalidResponse);
  }
}
