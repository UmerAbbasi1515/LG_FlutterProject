import 'dart:convert';
import 'package:flutter/foundation.dart';
import 'package:http/http.dart' as http;
import 'package:localgovernment_project/data/helpers/base_client.dart';
import 'package:localgovernment_project/data/models/auth_models/validate_user_model.dart';
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

  static Future<dynamic> isFeedbackAdded(String projectId) async {
    var data = {"ProjectId": projectId};
    var url = AppConfig().isAddProjectsFeedback;
    if (kDebugMode) {
      print(url);
      print(data);
    }

    var response = await BaseClientClass.postwithheader(url ?? "", data);

    if (response is http.Response) {
      final jsonData = jsonDecode(response.body);

      final apiResponse = ApiResponse<IsFeedbackAddedResponseModel>.fromJson(
        jsonData,
        (data) => IsFeedbackAddedResponseModel.fromJson(data),
      );
      return apiResponse;
    }
    throw Exception(AppMetaLabels().invalidResponse);
  }

  static Future<dynamic> submitProjectFeedback(
      FeedBackRequestModel param) async {
    String url = AppConfig().addProjectsFeedback ?? "";
    if (kDebugMode) {
      print(url);
    }

    var response = await BaseClientClass.submitProjectFeedback(param);

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

  static Future<dynamic> getFeedbackDetail(String projectID) async {
    var data = {
      "projectId": projectID,
    };

    var url = AppConfig().getProjectsFeedback;

    var response = await BaseClientClass.postwithheader(url ?? "", data);

    if (response is http.Response) {
      final jsonData = jsonDecode(response.body);

      final apiResponse = ApiResponse<GetFeedbackDetailResponse>.fromJson(
        jsonData,
        (data) => GetFeedbackDetailResponse.fromJson(data),
      );

      return apiResponse;
    }

    throw Exception(AppMetaLabels().invalidResponse);
  }
}
