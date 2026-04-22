// user validate
class ValidateUserModel {
  final String otpCode;
  final String isPasswordSet;

  ValidateUserModel({required this.otpCode, required this.isPasswordSet});

  factory ValidateUserModel.fromJson(Map<String, dynamic> json) {
    return ValidateUserModel(
      otpCode: json['otpCode'] ?? '',
      isPasswordSet: json['isPasswordSet'] ?? '',
    );
  }
}

class PasswordSetData1 {
  final String message;

  PasswordSetData1({required this.message});

  factory PasswordSetData1.fromJson(Map<String, dynamic> json) {
    return PasswordSetData1(
      message: json['message'] ?? '',
    );
  }
}

class CommonMessageModel {
  final String message;
  final String messageUr;

  CommonMessageModel({required this.message, required this.messageUr});

  factory CommonMessageModel.fromJson(Map<String, dynamic> json) {
    return CommonMessageModel(
      message: json['message'] ?? '',
      messageUr: json['messageUr'] ?? '',
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

  UserModel({
    this.id,
    this.nameEn,
    this.nameUr,
    this.phone,
    this.email,
    this.address,
    this.addressUr,
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
    );
  }
}
