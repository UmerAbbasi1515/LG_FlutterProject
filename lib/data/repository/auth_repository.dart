import 'package:localgovernment_project/data/services/auth_services/auth_services.dart';
import 'package:localgovernment_project/data/services/auth_services/country_picker_services.dart';
import 'package:localgovernment_project/data/services/auth_services/language_service.dart';

class CommonRepository {
  static Future<dynamic> countryPicker() => CountryPickerServices.getData();
  static Future<dynamic> getLanguage() => UserLanguageServices.getlanguage();
  static Future<dynamic> updateLanguage(langId) =>
      UserLanguageServices.updateLanguage(langId);
  static Future<dynamic> validateUser() => AuthServices.validateUser();
  static Future<dynamic> verifyOtp(
          String? otpCode, String? otpCodeForVerifyOTP, String? status) =>
      AuthServices.verfiyUserOTP(otpCode, otpCodeForVerifyOTP, status);

  static Future<dynamic> setPassword(String? mobile, String? password) =>
      AuthServices.setPassword(mobile, password);
  static Future<dynamic> loginWithPassword(String? mobile, String? password) =>
      AuthServices.loginWithPassword(mobile, password);
}
