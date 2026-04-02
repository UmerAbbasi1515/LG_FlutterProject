import 'dart:convert';

import 'package:flutter/foundation.dart';
import 'package:http/http.dart' as http;
import 'package:localgovernment_project/data/helpers/base_client.dart';
import 'package:localgovernment_project/data/models/common_response_model.dart';
import 'package:localgovernment_project/data/models/project_model/project_model.dart';
import 'package:localgovernment_project/utils/constants/app_config.dart';
import 'package:localgovernment_project/utils/constants/meta_labels.dart';

class ProjectServices {
  static Future<dynamic> getProjects() async {
    var data = {};
    var url = AppConfig().getProjects;
    if (kDebugMode) {
      print(url);
    }

    var response = await BaseClientClass.postwithheader(url ?? "", data);

    if (response is http.Response) {
      final jsonData = jsonDecode(response.body);

      final apiResponse = ApiResponse<List<ProjectVM>>.fromJson(
        jsonData,
        (data) {
          if (data == null) return [];

          final list = data is List ? data : data['data'];

          if (list == null) return [];

          return (list as List).map((e) => ProjectVM.fromJson(e)).toList();
        },
      );
      return apiResponse;
    }
    throw Exception(AppMetaLabels().invalidResponse);
  }

  static Future<dynamic> getProjectsWithFilter(
      String searchType, String search) async {
    var data = {"searchType": searchType, "search": search};
    var url = AppConfig().getProjectsFilter;
    if (kDebugMode) {
      print(url);
    }

    var response = await BaseClientClass.postwithheader(url ?? "", data);

    if (response is http.Response) {
      final jsonData = jsonDecode(response.body);

      final apiResponse = ApiResponse<List<ProjectVM>>.fromJson(
        jsonData,
        (data) {
          if (data == null) return [];

          final list = data is List ? data : data['data'];

          if (list == null) return [];

          return (list as List).map((e) => ProjectVM.fromJson(e)).toList();
        },
      );
      return apiResponse;
    }
    throw Exception(AppMetaLabels().invalidResponse);
  }

  static Future<dynamic> submitProjectFeedback(FeedBackRequestModel param) async {
    var data = {
      "name": param.name??"", 
      "email": param.email,
      "phone": param.phone,
      "complaintFeedbackText": param.complaintFeedbackText,
      "audio": param.audioFile,
      "video": param.videoFile,
      "image": param.imageFile,
    };
    var url = AppConfig().addProjectsFeedback;
    if (kDebugMode) {
      print(url);
    }

    var response = await BaseClientClass.postwithheader(url ?? "", data);

    if (response is http.Response) {
      final jsonData = jsonDecode(response.body);

      final apiResponse = ApiResponse<dynamic>.fromJson(
        jsonData,
        (data) {
          if (data == null) return [];
        },
      );
      return apiResponse;
    }
    throw Exception(AppMetaLabels().invalidResponse);
  }
}
