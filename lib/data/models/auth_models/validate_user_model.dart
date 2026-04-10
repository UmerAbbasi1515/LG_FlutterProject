// user validate
import 'package:get/get.dart';

class LoginData {
  final String otpCode;

  LoginData({required this.otpCode});

  factory LoginData.fromJson(Map<String, dynamic> json) {
    return LoginData(
      otpCode: json['otpCode'] ?? '',
    );
  }
}

class PasswordSetData {
  final String password;

  PasswordSetData({required this.password});

  factory PasswordSetData.fromJson(Map<String, dynamic> json) {
    return PasswordSetData(
      password: json['password'] ?? '',
    );
  }
}

// User OTP
class OtpData {
  final UserModel user;
  final String token;

  OtpData({
    required this.user,
    required this.token,
  });

  factory OtpData.fromJson(Map<String, dynamic> json) {
    return OtpData(
      user: UserModel.fromJson(json['user'] ?? {}),
      token: json['token'] ?? '',
    );
  }
}

class UserModel {
  int? id;
  String? nameEn;
  String? nameUr;
  String? phone;
  String? email;
  String? address;
  String? addressUr;
  RxBool? isFirstTimeLogin;

  UserModel({
    this.id,
    this.nameEn,
    this.nameUr,
    this.phone,
    this.email,
    this.address,
    this.addressUr,
    this.isFirstTimeLogin,
  });

  factory UserModel.fromJson(Map<String, dynamic> json) {
    return UserModel(
      id: json['id'] ?? 0,
      nameEn: json['nameEn'] ?? '',
      nameUr: json['nameUr'] ?? '',
      phone: json['phone'] ?? '',
      email: json['email'] ?? '',
      address: json['address'] ?? '',
      addressUr: json['addressUr'] ?? '',
      isFirstTimeLogin: json['isFirstTimeLogin'] ?? true.obs,
    );
  }
}
