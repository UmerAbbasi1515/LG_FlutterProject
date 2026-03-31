// To parse this JSON data, do
//
//     final tenantUpdateProfileModel = tenantUpdateProfileModelFromJson(jsonString);

import 'dart:convert';

TenantUpdateProfileModel tenantUpdateProfileModelFromJson(String? str) =>
    TenantUpdateProfileModel.fromJson(json.decode(str!));

String? tenantUpdateProfileModelToJson(TenantUpdateProfileModel data) =>
    json.encode(data.toJson());

class TenantUpdateProfileModel {
  TenantUpdateProfileModel({
    this.status,
    this.addServiceRequest,
    this.message,
  });

  String? status;
  AddServiceRequest? addServiceRequest;
  String? message;

  factory TenantUpdateProfileModel.fromJson(Map<String?, dynamic> json) =>
      TenantUpdateProfileModel(
        status: json["status"],
        addServiceRequest:
            AddServiceRequest.fromJson(json["addServiceRequest"]),
        message: json["message"],
      );

  Map<String?, dynamic> toJson() => {
        "status": status,
        "addServiceRequest": addServiceRequest!.toJson(),
        "message": message,
      };
}

class AddServiceRequest {
  AddServiceRequest({
    this.caseNo,
  });

  int? caseNo;

  factory AddServiceRequest.fromJson(Map<String?, dynamic> json) =>
      AddServiceRequest(
        caseNo: json["caseNo"],
      );

  Map<String?, dynamic> toJson() => {
        "caseNo": caseNo,
      };
}



TenantProfileModel tenantProfileModelFromJson(String? str) =>
    TenantProfileModel.fromJson(json.decode(str!));

String? tenantProfileModelToJson(TenantProfileModel data) =>
    json.encode(data.toJson());

class TenantProfileModel {
  TenantProfileModel({
    this.status,
    this.statuCode,
    this.profile,
    this.message,
  });

  String? status;
  String? statuCode;
  Profile? profile;
  String? message;

  factory TenantProfileModel.fromJson(Map<String?, dynamic> json) =>
      TenantProfileModel(
        status: json["status"],
        statuCode: json["statuCode"],
        profile: Profile.fromJson(json["profile"]),
        message: json["message"],
      );

  Map<String?, dynamic> toJson() => {
        "status": status,
        "statuCode": statuCode,
        "profile": profile!.toJson(),
        "message": message,
      };
}

class Profile {
  Profile({
    this.tenantId,
    this.name,
    this.nameAr,
    this.addressAr,
    this.mobile,
    this.email,
    this.nationality,
    this.phone,
    this.address,
    this.photoUrl,
    this.fax,
    this.termsAndConditions,
  });

  int? tenantId;
  String? name;
  String? nameAr;
  String? addressAr;
  String? mobile;
  String? email;
  String? nationality;
  String? phone;
  String? address;
  String? photoUrl;
  String? fax;
  String? termsAndConditions;

  factory Profile.fromJson(Map<String?, dynamic> json) {
    String? nameAr = json["nameAR"];
    if (nameAr == ' ') nameAr = 'اسم عربي';
    return Profile(
      tenantId: json["tenantId"],
      name: json["name"],
      nameAr: nameAr,
      addressAr: json["addressAR"],
      mobile: json["mobile"] ?? "",
      email: json["email"],
      nationality: json["nationality"],
      phone: json["phone"],
      address: json["address"],
      photoUrl: json["photoUrl"],
      fax: json["fax"],
      termsAndConditions: json["termsAndConditions"],
    );
  }

  Map<String?, dynamic> toJson() => {
        "tenantId": tenantId,
        "name": name,
        "nameAR": nameAr,
        "addressAR": addressAr,
        "mobile": mobile,
        "email": email,
        "nationality": nationality,
        "phone": phone,
        "address": address,
        "photoUrl": photoUrl,
        "fax": fax,
        "termsAndConditions": termsAndConditions,
      };
}
