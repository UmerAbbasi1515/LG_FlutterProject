// ignore_for_file: unnecessary_null_comparison

import 'dart:async';
import 'dart:convert';
import 'dart:io';
import 'package:flutter/foundation.dart';
import 'package:get/get.dart' as getx;
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'package:localgovernment_project/data/helpers/encription.dart';
import 'package:localgovernment_project/data/helpers/session_controller.dart';
import 'package:localgovernment_project/data/models/project_model/project_model.dart';
import 'package:localgovernment_project/utils/constants/app_config.dart';
import 'package:localgovernment_project/utils/constants/global_preferences.dart';
import 'package:localgovernment_project/utils/constants/meta_labels.dart';
import 'package:localgovernment_project/utils/styles/colors.dart';
import 'package:localgovernment_project/views/auth/auth_flow/password_screen.dart';
import 'package:localgovernment_project/views/common/no_internet_screen.dart';
import 'package:localgovernment_project/views/widgets/snackbar_widget.dart';

class BaseClientClass {
  static const int timeOutDuration = 60;
  static String dumnyUrl = '';

  static Future<dynamic> post(String url, data, {String? token}) async {
    token ??= SessionController().getToken();
    var forTestingdata = data;
    var data1 = await encriptdata(data);
    data = {"requestBody": data1};
    if (kDebugMode) {
      print('Encripted Data Post $url :::: => $data');
      print('Token Post :::: => $token');
    }
    http.Response response;
    try {
      response = await http
          .post(
            Uri.parse(url),
            body: json.encode(data),
            headers: {
              "Content-Type": "application/json",
              'Authorization': 'Bearer $token',
            },
            encoding: Encoding.getByName('utf-8'),
          )
          .timeout(const Duration(seconds: timeOutDuration));
      if (kDebugMode) {
        print('response:: ${response.statusCode}');
      }
      return _getResponse(response, url, forTestingdata);
    } on SocketException {
      if (kDebugMode) {
        print('Response :: BCC SocketException:: No internet connection');
      }
      await Get.to(() => const NoInternetScreen());
      bool isPasswordSet = await GlobalPreferences.getBool(
              GlobalPreferencesLabels.isPasswordSet) ??
          false;

      Get.offAll(() => PasswordScreen(
            isPasswordSet: isPasswordSet.toString().obs,
          ));
      return SessionController().getLanguage() == 1
          ? 'No internet connection'
          : 'لا يوجد اتصال بالإنترنت';
    } on TimeoutException {
      getx.Get.snackbar(
        AppMetaLabels().error,
        AppMetaLabels().connectionTimedOut,
        backgroundColor: AppColors.white54,
      );
      return AppMetaLabels().connectionTimedOut;
    } catch (e) {
      if (kDebugMode) {
        print(e);
      }
      return AppMetaLabels().anyError;
    }
  }

////////
  static Future<dynamic> postwithheader(String url, data,
      {String? token}) async {
    token ??= SessionController().getToken();

    if (kDebugMode) {
      print(token);
    }
    var forTestingdata = data;
    data = {"requestBody": encriptdata(data)};
    if (kDebugMode) {
      print('Encripted Data PostWithHeader :::: => $data');
      print('Encripted Data Testing ::::::::::: :::: => ${json.encode(data)}');
      print('Token PostWithHeader :::: => $token');
    }
    http.Response response;
    try {
      response = await http
          .post(
            Uri.parse(url),
            body: json.encode(data),
            headers: {
              "Content-Type": "application/json",
              'Authorization': 'Bearer $token',
            },
            encoding: Encoding.getByName('utf-8'),
          )
          .timeout(const Duration(seconds: timeOutDuration));
      if (kDebugMode) {
        print('Request: ${response.request}');
        print('End: $url');
        print('response:: ${response.statusCode}');
      }
      final jsonData = jsonDecode(response.body);
      if (kDebugMode) {
        print(jsonData['Message']);
      }
      if (jsonData['Message']
          .toString()
          .contains("Unencrypted requests are not allowed.")) {
        SnakBarWidget.getSnackBarError(
            AppMetaLabels().error,
            SessionController().getLanguage() == 1
                ? jsonData['Message']
                : jsonData['MessageUr']);
        return;
      }

      if (jsonData['message'] == 'unauthorized') {
        SnakBarWidget.getSnackBarErrorBlue(
            AppMetaLabels().error, AppMetaLabels().unAuthPlzRelogin);
        SessionController().resetSession();
        bool isPasswordSet = await GlobalPreferences.getBool(
                GlobalPreferencesLabels.isPasswordSet) ??
            false;

        Get.offAll(() => PasswordScreen(
              isPasswordSet: isPasswordSet.toString().obs,
            ));
      }

      return _getResponse(response, url, forTestingdata);
    } on SocketException {
      if (kDebugMode) {
        print('Response :: BCC SocketException:: No internet connection');
      }
      await Get.to(() => const NoInternetScreen());
      // Get.offAll(() => const PasswordScreen());
      return 'No internet connection';
    } on TimeoutException {
      if (kDebugMode) {
        print('Response ::TimeoutException:: Time out');
      }
      getx.Get.snackbar(
        AppMetaLabels().error,
        AppMetaLabels().connectionTimedOut,
        backgroundColor: AppColors.white54,
      );
      return AppMetaLabels().connectionTimedOut;
    } catch (e) {
      if (kDebugMode) {
        print('Response ::Catch e.toString():: ${e.toString()}');
        print('Response ::Catch:: $e');
      }
      return AppMetaLabels().anyError;
    }
  }

/////////
  static Future<dynamic> postwithheaderwithouttoken(
    String url,
    data,
  ) async {
    dumnyUrl = url;
    var forTestingdata = data;
    data = {"requestBody": encriptdata(data)};
    if (kDebugMode) {
      print('Encripted Data Postwithheaderwithouttoken :::: => $data');
    }

    http.Response response;
    try {
      response = await http
          .post(
            Uri.parse(url),
            body: json.encode(data),
            headers: {
              "Content-Type": "application/json",
              'Authorization': 'Bearer '
            },
            encoding: Encoding.getByName('utf-8'),
          )
          .timeout(const Duration(seconds: timeOutDuration));

      if (kDebugMode) print('Request: ${response.request}');
      // print('Headers: ${response.request.headers}');
      if (kDebugMode) print('End: $url');
      if (kDebugMode) print('response:: ${response.statusCode}');

      final jsonData = jsonDecode(response.body);
      if (kDebugMode) {
        print(jsonData['message']);
      }
      if (jsonData['Message']
          .toString()
          .contains("Unencrypted requests are not allowed.")) {
        SnakBarWidget.getSnackBarError(
            AppMetaLabels().error,
            SessionController().getLanguage() == 1
                ? jsonData['Message']
                : jsonData['MessageUr']);
        return;
      }
      if (jsonData['message'] == 'unauthorized') {
        SnakBarWidget.getSnackBarErrorBlue(
            AppMetaLabels().error, AppMetaLabels().unAuthPlzRelogin);
        SessionController().resetSession();
        bool isPasswordSet = await GlobalPreferences.getBool(
                GlobalPreferencesLabels.isPasswordSet) ??
            false;

        Get.offAll(() => PasswordScreen(
              isPasswordSet: isPasswordSet.toString().obs,
            ));
      }

      return _getResponse(response, url, forTestingdata);
    } on SocketException {
      if (kDebugMode) {
        print('Response :: BCC SocketException:: No internet connection');
      }
      await Get.to(() => const NoInternetScreen());
      bool isPasswordSet = await GlobalPreferences.getBool(
              GlobalPreferencesLabels.isPasswordSet) ??
          false;

      Get.offAll(() => PasswordScreen(
            isPasswordSet: isPasswordSet.toString().obs,
          ));

      return 'No internet connection';
    } on TimeoutException {
      getx.Get.snackbar(
        AppMetaLabels().error,
        AppMetaLabels().connectionTimedOut,
        backgroundColor: AppColors.white54,
      );
      return AppMetaLabels().connectionTimedOut;
    } catch (e) {
      if (kDebugMode) print(e);
      return AppMetaLabels().anyError;
    }
  }

///////
  static Future<dynamic> uploadFile(
      String url, Map<String, String> fields, String fileField, String filePath,
      {String? token}) async {
    bool isInternetConnected = await BaseClientClass.isInternetConnected();
    if (!isInternetConnected) {
      await Get.offAll(const NoInternetScreen());
      bool isPasswordSet = await GlobalPreferences.getBool(
              GlobalPreferencesLabels.isPasswordSet) ??
          false;

      Get.offAll(() => PasswordScreen(
            isPasswordSet: isPasswordSet.toString().obs,
          ));
      return;
    }
    String bearerToken = token ?? SessionController().getToken() ?? '';
    try {
      http.MultipartRequest request =
          http.MultipartRequest("POST", Uri.parse(url));
      // if (filePath != null) {
      if (filePath != '') {
        if (kDebugMode) {
          print('Inside ::::: ');
        }
        http.MultipartFile multipartFile =
            await http.MultipartFile.fromPath(fileField, filePath);
        request.files.add(multipartFile);
      }
      request.fields.addAll(fields);
      request.headers.addAll({
        "Content-Type": "application/json",
        'Authorization': 'Bearer $bearerToken',
      });
      if (kDebugMode) {
        print('Request :::::::: $request');
      }
      http.StreamedResponse response = await request.send();

      // response.statusCode == 401 putting this condition because
      // in multipart we are not calling _getResponse for handle the response
      if (response.statusCode == 401) {
        bool isPasswordSet = await GlobalPreferences.getBool(
                GlobalPreferencesLabels.isPasswordSet) ??
            false;

        SnakBarWidget.getSnackBarErrorBlue(
            AppMetaLabels().error, AppMetaLabels().unAuthPlzRelogin);
        Get.offAll(() => PasswordScreen(
              isPasswordSet: isPasswordSet.toString().obs,
            ));
        return AppMetaLabels().unauthorized;
      }
      // Response of UploadFile
      // The below lines for print the response of uploadFile
      var res = await http.Response.fromStream(response);
      // print('Respone :11::22:: ${res.body}');

      final jsonData = jsonDecode(res.body);
      if (kDebugMode) {
        print(jsonData['message']);
      }
      if (jsonData['message'] == 'unauthorized') {
        SnakBarWidget.getSnackBarErrorBlue(
            AppMetaLabels().error, AppMetaLabels().unAuthPlzRelogin);
        SessionController().resetSession();
        bool isPasswordSet = await GlobalPreferences.getBool(
                GlobalPreferencesLabels.isPasswordSet) ??
            false;

        Get.offAll(() => PasswordScreen(
              isPasswordSet: isPasswordSet.toString().obs,
            ));
      }

      return response;
    } catch (e) {
      if (kDebugMode) {
        print('Catch ========> From BaseClient $e');
        print(e);
        print(e.toString());
      }

      return 0;
    }
  }

  static Future<dynamic> submitProjectFeedback(
      FeedBackRequestModel param) async {
    var data0 = {
      'NameEn': param.name ?? "",
      'NameUr': param.name ?? "", // adjust if needed
      'Email': param.email ?? "",
      'Phone': param.phone ?? "",
      'ProjectId': param.projectId ?? "",
      'TextMessage': param.complaintFeedbackText ?? "",
    };
    var data = {
      'NameEn': encriptdatasingle(param.name).toString(),
      'NameUr': encriptdatasingle(param.name).toString(), // adjust if needed
      'Email': encriptdatasingle(param.email).toString(),
      'Phone': encriptdatasingle(param.phone).toString(),
      'ProjectId': encriptdatasingle(param.projectId.toString()).toString(),
      'TextMessage': param.complaintFeedbackText == ""
          ? ""
          : encriptdatasingle(param.complaintFeedbackText).toString(),
    };
    if (kDebugMode) {
      print(data0);
      print(data);
    }
    String url = AppConfig().addProjectsFeedback ?? "";

    try {
      var request = http.MultipartRequest("POST", Uri.parse(url));

      // ================= TEXT FIELDS =================
      request.fields.addAll(data);

      // ================= FILES =================

      // IMAGE
      if (param.imageFile != null) {
        request.files.add(
          await http.MultipartFile.fromPath(
            "ImageFile",
            param.imageFile!.path,
          ),
        );
      }

      // VIDEO
      if (param.videoFile != null) {
        request.files.add(
          await http.MultipartFile.fromPath(
            "VideoFile",
            param.videoFile!.path,
          ),
        );
      }

      // AUDIO
      if (param.audioFile != null) {
        request.files.add(
          await http.MultipartFile.fromPath(
            "AudioFile",
            param.audioFile!.path,
          ),
        );
      }

      // ================= HEADERS =================
      String token = SessionController().getToken() ?? "";
      request.headers.addAll({
        'Authorization': 'Bearer $token',
      });

      var response = await request.send();
      if (response.statusCode == 400) {
        SnakBarWidget.getSnackBarError(
            AppMetaLabels().error, AppMetaLabels().badRequest);
        return;
      }
      if (response.statusCode == 401) {
        bool isPasswordSet = await GlobalPreferences.getBool(
                GlobalPreferencesLabels.isPasswordSet) ??
            false;
        Get.offAll(() => PasswordScreen(
              isPasswordSet: isPasswordSet.toString().obs,
            ));
        return;
      }
      var res = await http.Response.fromStream(response);

      if (kDebugMode) {
        print(res.body);
      }

      return res;
    } catch (e) {
      if (kDebugMode) {
        print("Upload Error: $e");
      }
      return null;
    }
  }

  static Future<bool> isInternetConnected() async {
    try {
      final result = await InternetAddress.lookup('example.com');
      if (result.isNotEmpty && result[0].rawAddress.isNotEmpty) {
        return true;
      }
    } on SocketException catch (_) {
      return false;
    }
    return false;
  }

  static dynamic _getResponse(
      http.Response response, String url, dynamic data) async {
    if (kDebugMode) {
      print(
          'Response Body :::: inside getResponse:: $url ::: $data Test:=> ${response.body}');
    }

    if (response.body.contains('BadRequestExecution Timeout Expired')) {
      if (kDebugMode) {
        print('Response inhelper :: ${response.body}');
      }
      return AppMetaLabels().connectionTimedOut;
    }
    switch (response.statusCode) {
      case 200:
        return response;
      case 400:
        return AppMetaLabels().badRequest;
      case 401:
        SnakBarWidget.getSnackBarErrorBlue(
            AppMetaLabels().error, AppMetaLabels().unAuthPlzRelogin);
        bool isPasswordSet = await GlobalPreferences.getBool(
                GlobalPreferencesLabels.isPasswordSet) ??
            false;

        Get.offAll(() => PasswordScreen(
              isPasswordSet: isPasswordSet.toString().obs,
            ));
        return AppMetaLabels().unauthorized;
      case 403:
        SnakBarWidget.getSnackBarErrorBlue(
            AppMetaLabels().error, AppMetaLabels().unAuthPlzRelogin);
        bool isPasswordSet = await GlobalPreferences.getBool(
                GlobalPreferencesLabels.isPasswordSet) ??
            false;

        Get.offAll(() => PasswordScreen(
              isPasswordSet: isPasswordSet.toString().obs,
            ));
        return AppMetaLabels().unauthorized;
      case 404:
        return AppMetaLabels().noDatafound;
      case 500:
        if (kDebugMode) {
          print(response.body);
        }
        return AppMetaLabels().anyError;

      case 501:
        if (kDebugMode) {
          print(response.body);
        }
        getx.Get.snackbar(
          AppMetaLabels().error,
          AppMetaLabels().processingError,
          backgroundColor: AppColors.white54,
        );
        return AppMetaLabels().noDatafound;

      default:
        getx.Get.snackbar(
          AppMetaLabels().error,
          AppMetaLabels().couldNotConnectToServer,
          backgroundColor: AppColors.white54,
        );
        return AppMetaLabels().couldNotConnectToServer;
    }
  }
}
