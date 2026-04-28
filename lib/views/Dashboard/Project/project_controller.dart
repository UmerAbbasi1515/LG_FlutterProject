import 'dart:io';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:localgovernment_project/data/helpers/base_client.dart';
import 'package:localgovernment_project/data/helpers/session_controller.dart';
import 'package:localgovernment_project/data/models/auth_models/validate_user_model.dart';
import 'package:localgovernment_project/data/models/common_response_model.dart';
import 'package:localgovernment_project/data/models/project_model/project_model.dart';
import 'package:localgovernment_project/data/repository/project_repository.dart';
import 'package:localgovernment_project/utils/constants/meta_labels.dart';
import 'package:localgovernment_project/views/Dashboard/Project/get_feedback_screen.dart';
import 'package:localgovernment_project/views/common/no_internet_screen.dart';
import 'package:localgovernment_project/views/widgets/snackbar_widget.dart';

class ProjectController extends GetxController {
  RxBool loadingProjectsData = false.obs;
  RxBool temp = false.obs;
  RxString error = "".obs;

  Rx<ApiResponse<List<ProjectVM>>> model =
      ApiResponse<List<ProjectVM>>(data: []).obs;
  Rx<ApiResponse<IsFeedbackAddedResponseModel>> isFeedbackAddedModel =
      ApiResponse<IsFeedbackAddedResponseModel>().obs;
  Rx<ApiResponse<GetFeedbackDetailResponse?>> feedbackDetailModel =
      ApiResponse<GetFeedbackDetailResponse?>().obs;
  Rx<ApiResponse<List<GetFeedbackDetailResponse?>>> feedbackListDetailModel =
      ApiResponse<List<GetFeedbackDetailResponse>>().obs;
  Rx<ApiResponse<CommonMessageModel>> addFeedbackModel =
      ApiResponse<CommonMessageModel>().obs;

  String getInitials(String fullName) {
    if (fullName.trim().isEmpty) return '';

    List<String> parts = fullName.trim().split(RegExp(r'\s+'));

    // If only one name → return first letter
    if (parts.length == 1) {
      return parts[0].characters.first.toUpperCase();
    }

    // If multiple names → take first letter of each word
    String initials = parts.map((e) => e.characters.first.toUpperCase()).join();

    return initials;
  }

  String getUrl(FeedbackMedia e) {
    if (e == null) return "";
    var url = "";
    if (Platform.isIOS) {
      url = e.previewUrlI ?? "";
    } else {
      url = e.previewUrl ?? "";
    }
    return url;
  }

  final nameController = TextEditingController();
  final emailController = TextEditingController();
  final phoneController = TextEditingController();
  final complaintController = TextEditingController();

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
        model.value.data?.first.isFeedbackAdded = true;
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
        if (result.message == "Projects data not found") {
          SnakBarWidget.getSnackBarError(
              AppMetaLabels().error,
              SessionController().getLanguage() == 1
                  ? result.message ?? ""
                  : result.messageUr ?? "");
          error.value = SessionController().getLanguage() == 1
              ? result.message ?? ""
              : result.messageUr ?? "";
        } else {
          error.value = '';
          model.value = result;
        }
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

  Future<void> isFeedbackAdded(String projectID) async {
    try {
      bool isInternetConnected = await BaseClientClass.isInternetConnected();
      if (!isInternetConnected) {
        await Get.to(() => const NoInternetScreen());
      }
      loadingProjectsData.value = true;
      var result = await ProjectRepository.isFeedbackAdded(projectID);
      if (result is ApiResponse<IsFeedbackAddedResponseModel>) {
        error.value = '';
        isFeedbackAddedModel.value = result;
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

  var resultAddFeddback = ApiResponse<dynamic>();
  Future<void> submitFeedBack(FeedBackRequestModel feebackrquestModel,
      ProjectVM selectedProject) async {
    try {
      bool isInternetConnected = await BaseClientClass.isInternetConnected();
      if (!isInternetConnected) {
        await Get.to(() => const NoInternetScreen());
      }
      loadingProjectsData.value = true;
      var result =
          await ProjectRepository.submitProjectFeedback(feebackrquestModel);
      if (result is ApiResponse<CommonMessageModel>) {
        error.value = '';
        addFeedbackModel.value = result;
        if (addFeedbackModel.value.data?.message ==
            "Feedback added successfully") {
          SnakBarWidget.getSnackBarErrorBlue(
              AppMetaLabels().success,
              SessionController().getLanguage() == 1
                  ? addFeedbackModel.value.data?.message ?? ""
                  : addFeedbackModel.value.data?.messageUr ?? "");
          Get.off(() => GetFeedbackComplaintScreen(
                projectId: feebackrquestModel.projectId.toString(),
                selectproject: selectedProject,
              ));
        } else {
          SnakBarWidget.getSnackBarErrorBlue(
              AppMetaLabels().error,
              SessionController().getLanguage() == 1
                  ? addFeedbackModel.value.data?.message ?? ""
                  : addFeedbackModel.value.data?.messageUr ?? "");
        }
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

  Future<void> getProjectsFeedback(String projectID) async {
    try {
      bool isInternetConnected = await BaseClientClass.isInternetConnected();
      if (!isInternetConnected) {
        await Get.to(() => const NoInternetScreen());
      }
      loadingProjectsData.value = true;
      feedbackDetailModel.value = ApiResponse<GetFeedbackDetailResponse>();
      var result = await ProjectRepository.getFeedbackDetail(projectID);
      if (result is ApiResponse<GetFeedbackDetailResponse>) {
        error.value = '';
        feedbackDetailModel.value = result;
        if (kDebugMode) {
          print(feedbackDetailModel.value.data?.nameEn);
          print(feedbackDetailModel.value.data?.email);
          print(feedbackDetailModel.value.data?.phone);
        }
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

  Future<void> getProjectsMultipleFeedback(String projectID) async {
    try {
      bool isInternetConnected = await BaseClientClass.isInternetConnected();
      if (!isInternetConnected) {
        await Get.to(() => const NoInternetScreen());
      }
      loadingProjectsData.value = true;
      feedbackListDetailModel.value =
          ApiResponse<List<GetFeedbackDetailResponse>>();
      var result = await ProjectRepository.getFeedbackListDetail(projectID);
      if (result is ApiResponse<List<GetFeedbackDetailResponse>>) {
        error.value = '';
        feedbackListDetailModel.value = result;
        if (kDebugMode) {
          print(feedbackDetailModel.value.data?.nameEn);
          print(feedbackDetailModel.value.data?.email);
          print(feedbackDetailModel.value.data?.phone);
        }
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
