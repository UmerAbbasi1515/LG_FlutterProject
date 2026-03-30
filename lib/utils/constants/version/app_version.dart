import 'dart:async';
import 'dart:convert';
import 'dart:io';
import 'package:flutter/foundation.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'package:localgovernment_project/data/helpers/base_client.dart';
import 'package:localgovernment_project/data/helpers/session_controller.dart';
import 'package:localgovernment_project/views/common/no_internet_screen.dart';

class CheckVerion {
  Future<dynamic> fetchAppVersion() async {
    bool isInternetConnected = await BaseClientClass.isInternetConnected();
    if (!isInternetConnected) {
      await Get.offAll(const NoInternetScreen());
    }
    const String bundle = 'com.fab.properties';
    const String url = 'https://itunes.apple.com/lookup?bundleId=$bundle';
    http.Response response;
    try {
      response = await http
          .post(
            Uri.parse(url),
            encoding: Encoding.getByName('utf-8'),
          )
          .timeout(const Duration(seconds: 30));
      Map<String, dynamic> result = jsonDecode(response.body);
      if (result['resultCount'] > 0 &&
          result['results'] != null &&
          result['results'].length > 0) {
        SessionController().storeAppVerison =
            result['results'][0]['version'] ?? '';
        if (kDebugMode) {
          print('SessionController().storeAppVerison: ${SessionController().storeAppVerison}');
        }
      } else {
        throw 'Result Not Found';
      }

      return;
    } on SocketException {
      if (kDebugMode) {
        print('Response :: CheckVerion :: No internet connection');
      }

      return 'No internet connection';
    } on TimeoutException {
      if (kDebugMode) {
        print('Response ::TimeoutException:: Time out');
      }

      return;
    } catch (e) {
      return;
    }
  }
}
