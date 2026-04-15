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
  String? updateUserProfile;
  String? getProjects;
  String? getProjectsFilter;
  String? addProjectsFeedback;
  String? getProjectsFeedback;
  String? setPassword;
  String? loginWithPassword;

  factory AppConfig() {
    return _instance;
  }

  AppConfig._internel() {
    setUrls();
  }

  void setUrls() {
    if (kReleaseMode) isProcutionEnvironment = true;

    if (isProcutionEnvironment) {
      baseUrl = 'https://auth.api.ubspropt.com/api/'; // production url
    } else {
      baseUrl = 'http://localhost:5107/api/'; // development url
    }

    getLanguage = "${baseUrl!}Auth/GetLanguages";
    updateLanguage = "${baseUrl!}Auth/updateLanguage";
    getcountries = "${baseUrl!}Auth/getcountries";
    validateUser = "${baseUrl!}Auth/ValidateUser";
    verifyUserOTP = "${baseUrl!}Auth/VerifyUserOTP";
    setPassword = "${baseUrl!}Auth/SetUserPassword";
    loginWithPassword = "${baseUrl!}Auth/VerifyUserPassword";
    getUserProfile = "${baseUrl!}Profile/GetUserProfile";
    updateUserProfile = "${baseUrl!}Profile/UpdateUserProfile";
    getProjects = "${baseUrl!}Project/GetProjects";
    getProjectsFilter = "${baseUrl!}Project/GetProjectsFilter";
    addProjectsFeedback = "${baseUrl!}Project/AddProjectFeedback";
    getProjectsFeedback = "${baseUrl!}Project/GetProjectFeedback";
  }
}
