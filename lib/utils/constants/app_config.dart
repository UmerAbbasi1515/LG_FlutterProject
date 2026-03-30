

import 'package:flutter/foundation.dart';

class AppConfig {
  static final AppConfig _instance = AppConfig._internel();

  bool isProcutionEnvironment = false;
  String? baseUrl;

  String? getLanguage;
  String? updateLanguage;
  String? getcountries;
  String? validateUser;
  String? verifyUserOTP;
  String? getUserProfile;
  String? getProjects;

  factory AppConfig() {
    return _instance;
  }

  AppConfig._internel() {
    setUrls();
  }

  void setUrls() {
    if (kReleaseMode) isProcutionEnvironment = true;

    if(isProcutionEnvironment){
      baseUrl = 'https://auth.api.ubspropt.com/api/'; // production url
    }else{
      baseUrl = 'https://localhost:44387/api/'; // development url
    }


    getLanguage = "${baseUrl!}getLanguage";
    updateLanguage = "${baseUrl!}Auth/updateLanguage";
    getcountries = "${baseUrl!}Auth/getcountries";
    validateUser = "${baseUrl!}Auth/ValidateUser";
    verifyUserOTP = "${baseUrl!}Auth/VerifyUserOTP";
    verifyUserOTP = "${baseUrl!}Auth/VerifyUserOTP";
    getProjects = "${baseUrl!}Profile/GetUserProfile";
    getProjects = "${baseUrl!}Project/GetProjects";
  }
}
