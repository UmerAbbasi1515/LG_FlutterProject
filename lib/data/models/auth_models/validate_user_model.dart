// user validate
class LoginData {
  final String otpCode;

  LoginData({required this.otpCode});

  factory LoginData.fromJson(Map<String, dynamic> json) {
    return LoginData(
      otpCode: json['otpCode'] ?? '',
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

  UserModel({
     this.id,
     this.nameEn,
     this.nameUr,
     this.phone,
     this.email,
  });

  factory UserModel.fromJson(Map<String, dynamic> json) {
    return UserModel(
      id: json['id'] ?? 0,
      nameEn: json['nameEn'] ?? '',
      nameUr: json['nameUr'] ?? '',
      phone: json['phone'] ?? '',
      email: json['email'] ?? '',
    );
  }
}