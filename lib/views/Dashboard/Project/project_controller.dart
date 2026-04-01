import 'package:flutter/foundation.dart';
import 'package:get/get.dart';
import 'package:localgovernment_project/data/helpers/base_client.dart';
import 'package:localgovernment_project/data/models/common_response_model.dart';
import 'package:localgovernment_project/data/models/project_model/project_model.dart';
import 'package:localgovernment_project/data/repository/project_repository.dart';
import 'package:localgovernment_project/views/common/no_internet_screen.dart';

class ProjectController extends GetxController {
  RxBool loadingProjectsData = false.obs;
  RxString error = "".obs;

  Rx<ApiResponse<List<ProjectVM>>> model =
      ApiResponse<List<ProjectVM>>(data: []).obs;
  String getInitials(String fullName) {
    if (fullName.trim().isEmpty) return '';

    List<String> parts = fullName.trim().split(RegExp(r'\s+'));

    // If only one name → return first letter
    if (parts.length == 1) {
      return parts[0][0].toUpperCase();
    }

    // If multiple names → take first letter of each word
    String initials = parts.map((e) => e[0].toUpperCase()).join();

    return initials;
  }

  Future<void> getProjects() async {
    try {
      bool isInternetConnected = await BaseClientClass.isInternetConnected();
      if (!isInternetConnected) {
        await Get.to(() => const NoInternetScreen());
      }
      loadingProjectsData.value = true;
      var result = await ProjectRepository.getProjects();
      if (result is ApiResponse<List<ProjectVM>>) {
        error.value = '';
        model.value = result;
        update();
      } else {
        error.value = result;
      }
    } catch (e) {
      if (kDebugMode) {
        print('inside Catch $e}');
      }
    } finally {
      loadingProjectsData.value = false;
    }
  }

  Future<void> getProjectsWithFilter(String searchType, String search) async {
    try {
      bool isInternetConnected = await BaseClientClass.isInternetConnected();
      if (!isInternetConnected) {
        await Get.to(() => const NoInternetScreen());
      }
      loadingProjectsData.value = true;
      var result =
          await ProjectRepository.getProjectsWithFilter(searchType, search);
      if (result is ApiResponse<List<ProjectVM>>) {
        error.value = '';
        model.value = result;
        update();
      } else {
        error.value = result;
      }
    } catch (e) {
      if (kDebugMode) {
        print('inside Catch $e}');
      }
    } finally {
      loadingProjectsData.value = false;
    }
  }


}
