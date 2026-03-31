// To parse this JSON data, do
//
//     final tenantReadNotificationsModel = tenantReadNotificationsModelFromJson(jsonString);

import 'dart:convert';

import 'package:get/get.dart';

TenantReadNotificationsModel tenantReadNotificationsModelFromJson(String? str) =>
    TenantReadNotificationsModel.fromJson(json.decode(str!));

String? tenantReadNotificationsModelToJson(TenantReadNotificationsModel data) =>
    json.encode(data.toJson());
 
class TenantReadNotificationsModel {
  TenantReadNotificationsModel({
    this.status,
    this.statusCode,
    this.message,
  });

  String? status;
  String? statusCode;
  String? message;

  factory TenantReadNotificationsModel.fromJson(Map<String?, dynamic> json) =>
      TenantReadNotificationsModel(
        status: json["status"],
        statusCode: json["statusCode"],
        message: json["message"],
      );

  Map<String?, dynamic> toJson() => {
        "status": status,
        "statusCode": statusCode,
        "message": message,
      };
}



GetTenantNotificationsModel getTenantNotificationsModelFromJson(String? str) =>
    GetTenantNotificationsModel.fromJson(json.decode(str!));

String? getTenantNotificationsModelToJson(GetTenantNotificationsModel data) =>
    json.encode(data.toJson());

class GetTenantNotificationsModel {
  GetTenantNotificationsModel({
    this.statusCode,
    this.status,
    this.notifications,
    this.message,
  });

  String? statusCode;
  String? status;
  List<Notification>? notifications;
  String? message;

  factory GetTenantNotificationsModel.fromJson(Map<String?, dynamic> json) =>
      GetTenantNotificationsModel(
        statusCode: json["statusCode"],
        status: json["status"],
        notifications: List<Notification>.from(
            json["notifications"].map((x) => Notification.fromJson(x))),
        message: json["message"],
      );

  Map<String?, dynamic> toJson() => {
        "statusCode": statusCode,
        "status": status,
        "notifications":
            List<dynamic>.from(notifications!.map((x) => x.toJson())),
        "message": message,
      };
}

class Notification {
  Notification(
      {this.notificationId,
      this.createdOn,
      this.currentStatus,
      this.notificationTypeId,
      this.isRead,
      this.readOn,
      this.sent,
      this.sentOn,
      this.batch,
      this.userId,
      this.userName,
      this.mobile,
      this.title,
      this.description,
      this.notificationType,
      this.totalRecords,
      this.titleAR,
      this.descriptionAR});

  int? notificationId;
  String? createdOn;
  String? currentStatus;
  int? notificationTypeId;
  bool? isRead;
  String? readOn;
  bool? sent;
  String? sentOn;
  String? batch;
  int? userId;
  String? userName;
  String? mobile;
  String? title;
  String? description;
  String? notificationType;
  int? totalRecords;
  String? titleAR;
  String? descriptionAR;

  factory Notification.fromJson(Map<String?, dynamic> json) => Notification(
      notificationId: json["notificationId"],
      createdOn: json["createdOn"],
      currentStatus: json["currentStatus"],
      notificationTypeId: json["notificationTypeId"],
      isRead: json["isRead"],
      readOn: json["readOn"],
      sent: json["sent"],
      sentOn: json["sentOn"],
      batch: json["batch"],
      userId: json["userId"],
      userName: json["userName"],
      mobile: json["mobile"],
      title: json["title"],
      description: json["description"],
      notificationType: json["notificationType"],
      totalRecords: json["totalRecords"],
      titleAR: json["titleAR"],
      descriptionAR: json["descriptionAR"]);

  Map<String?, dynamic> toJson() => {
        "notificationId": notificationId,
        "createdOn": createdOn,
        "currentStatus": currentStatus,
        "notificationTypeId": notificationTypeId,
        "isRead": isRead,
        "readOn": readOn,
        "sent": sent,
        "sentOn": sentOn,
        "batch": batch,
        "userId": userId,
        "userName": userName,
        "mobile": mobile,
        "title": title,
        "description": description,
        "notificationType": notificationType,
        "totalRecords": totalRecords,
      };
}


TenantArchiveNotificationsModel tenantArchiveNotificationsModelFromJson(
        String? str) =>
    TenantArchiveNotificationsModel.fromJson(json.decode(str!));

String? tenantArchiveNotificationsModelToJson(
        TenantArchiveNotificationsModel data) =>
    json.encode(data.toJson());

class TenantArchiveNotificationsModel {
  TenantArchiveNotificationsModel({
    this.status,
    this.statusCode,
    this.message,
  });

  String? status;
  String? statusCode;
  String? message;

  factory TenantArchiveNotificationsModel.fromJson(Map<String?, dynamic> json) =>
      TenantArchiveNotificationsModel(
        status: json["status"],
        statusCode: json["statusCode"],
        message: json["message"],
      );

  Map<String?, dynamic> toJson() => {
        "status": status,
        "statusCode": statusCode,
        "message": message,
      };
}


TenantNotificationsDetailModel tenantNotificationsDetailModelFromJson(
        String? str) =>
    TenantNotificationsDetailModel.fromJson(json.decode(str!));

String? tenantNotificationsDetailModelToJson(
        TenantNotificationsDetailModel data) =>
    json.encode(data.toJson());

class TenantNotificationsDetailModel {
  TenantNotificationsDetailModel({
    this.statusCode,
    this.status,
    this.notification,
    this.message,
  });

  String? statusCode;
  String? status;
  Notification? notification;
  String? message;

  factory TenantNotificationsDetailModel.fromJson(Map<String?, dynamic> json) =>
      TenantNotificationsDetailModel(
        statusCode: json["statusCode"],
        status: json["status"],
        notification: Notification.fromJson(json["notification"]),
        message: json["message"],
      );

  Map<String?, dynamic> toJson() => {
        "statusCode": statusCode,
        "status": status,
        "notification": notification!.toJson(),
        "message": message,
      };
}


NotificationFiles notificationFilesFromJson(String? str) =>
    NotificationFiles.fromJson(json.decode(str!));

String? notificationFilesToJson(NotificationFiles data) =>
    json.encode(data.toJson());

class NotificationFiles {
  NotificationFiles({
    this.status,
    this.record,
  });

  String? status;
  List<Record>? record;

  factory NotificationFiles.fromJson(Map<String?, dynamic> json) =>
      NotificationFiles(
        status: json["status"],
        record:
            List<Record>.from(json["record"].map((x) => Record.fromJson(x))),
      );

  Map<String?, dynamic> toJson() => {
        "status": status,
        "record": List<dynamic>.from(record!.map((x) => x.toJson())),
      };
}

class Record {
  Record({this.fileId, this.fileName, this.uploadOn});

  int? fileId;
  String? fileName;
  RxBool? downloading = false.obs;
  String? uploadOn;

  factory Record.fromJson(Map<String?, dynamic> json) => Record(
      fileId: json["fileid"],
      fileName: json['fileSource'],
      uploadOn: json["uploadOn"]);

  Map<String?, dynamic> toJson() => {
        "fileId": fileId,
      };
}
