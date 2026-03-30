import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:localgovernment_project/data/helpers/base_client.dart';
import 'package:localgovernment_project/data/models/auth_models/country_model.dart';
import 'package:localgovernment_project/data/models/common_response_model.dart';
import 'package:localgovernment_project/utils/constants/app_config.dart';
import 'package:localgovernment_project/utils/constants/meta_labels.dart';

import '../../helpers/session_controller.dart';

class CountryPickerServices {
  static Future<dynamic> getData() async {
    final String url = AppConfig().getcountries??"";
    Map data = {};
    var response = await BaseClientClass.postwithheader(url, data,
        token: SessionController().getLoginToken());
    if (response is http.Response) {
      final jsonData = jsonDecode(response.body);
      final apiResponse = ApiResponse<List<Country>>.fromJson(
        jsonData,
        (data) => (data as List)
            .map((e) => Country.fromJson(e))
            .toList(),
      );

      return apiResponse;
    }
      throw Exception(AppMetaLabels().invalidResponse);
  }
}
