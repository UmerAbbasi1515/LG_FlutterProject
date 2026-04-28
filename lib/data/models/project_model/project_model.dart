import 'dart:io';

class ProjectVM {
  ProjectVM({
    required this.id,
    required this.nameEn,
    required this.nameUr,
    required this.descriptionEn,
    required this.descriptionUr,
    required this.locationEn,
    required this.locationUr,
    required this.adpYear,
    required this.suspended,
    required this.createdAt,
    required this.halka,
    required this.uc,
    required this.ward,
    required this.pmo,
    required this.projectLeader,
    required this.committeeMembersNameEn,
    required this.committeeMembersNameUr,
    required this.isFeedbackAdded,
  });

  final int? id;
  final String? nameEn;
  final String? nameUr;
  final String? descriptionEn;
  final String? descriptionUr;
  final String? locationEn;
  final String? locationUr;
  final String? adpYear;
  final bool? suspended;
  final DateTime? createdAt;
  final Halka? halka;
  final Uc? uc;
  final Ward? ward;
  final Pmo? pmo;
  final ProjectLeader? projectLeader;
  final String? committeeMembersNameEn;
  final String? committeeMembersNameUr;
  bool? isFeedbackAdded;

  factory ProjectVM.fromJson(Map<String, dynamic> json) {
    return ProjectVM(
      id: json["id"],
      nameEn: json["nameEn"],
      nameUr: json["nameUr"],
      descriptionEn: json["descriptionEn"],
      descriptionUr: json["descriptionUr"],
      locationEn: json["locationEn"],
      locationUr: json["locationUr"],
      adpYear: json["adpYear"],
      suspended: json["suspended"],
      createdAt: DateTime.tryParse(json["createdAt"] ?? ""),
      halka: json["halka"] == null ? null : Halka.fromJson(json["halka"]),
      uc: json["uc"] == null ? null : Uc.fromJson(json["uc"]),
      ward: json["ward"] == null ? null : Ward.fromJson(json["ward"]),
      pmo: json["pmo"] == null ? null : Pmo.fromJson(json["pmo"]),
      projectLeader: json["projectLeader"] == null
          ? null
          : ProjectLeader.fromJson(json["projectLeader"]),
      committeeMembersNameEn: json["committee_members_name_en"],
      committeeMembersNameUr: json["committee_members_name_ur"],
      isFeedbackAdded: json["isFeedbackAdded"],
    );
  }
}

class Halka {
  Halka({
    required this.halkaId,
    required this.halkaNameEn,
    required this.halkaNameUr,
  });

  final int? halkaId;
  final String? halkaNameEn;
  final String? halkaNameUr;

  factory Halka.fromJson(Map<String, dynamic> json) {
    return Halka(
      halkaId: json["halkaId"],
      halkaNameEn: json["halkaNameEn"],
      halkaNameUr: json["halkaNameUr"],
    );
  }
}

class Pmo {
  Pmo({
    required this.pmoId,
    required this.pmoNameEn,
    required this.pmoNameUr,
  });

  final int? pmoId;
  final String? pmoNameEn;
  final String? pmoNameUr;

  factory Pmo.fromJson(Map<String, dynamic> json) {
    return Pmo(
      pmoId: json["pmoId"],
      pmoNameEn: json["pmoNameEn"],
      pmoNameUr: json["pmoNameUr"],
    );
  }
}

class ProjectLeader {
  ProjectLeader({
    required this.projectLeaderId,
    required this.projectLeaderNameEn,
    required this.projectLeaderNameUr,
  });

  final int? projectLeaderId;
  final String? projectLeaderNameEn;
  final String? projectLeaderNameUr;

  factory ProjectLeader.fromJson(Map<String, dynamic> json) {
    return ProjectLeader(
      projectLeaderId: json["projectLeaderId"],
      projectLeaderNameEn: json["projectLeaderNameEn"],
      projectLeaderNameUr: json["projectLeaderNameUr"],
    );
  }
}

class Uc {
  Uc({
    required this.ucId,
    required this.ucNameEn,
    required this.ucNameUr,
  });

  final int? ucId;
  final String? ucNameEn;
  final String? ucNameUr;

  factory Uc.fromJson(Map<String, dynamic> json) {
    return Uc(
      ucId: json["ucId"],
      ucNameEn: json["ucNameEn"],
      ucNameUr: json["ucNameUr"],
    );
  }
}

class Ward {
  Ward({
    required this.wardId,
    required this.wardNameEn,
    required this.wardNameUr,
  });

  final int? wardId;
  final String? wardNameEn;
  final String? wardNameUr;

  factory Ward.fromJson(Map<String, dynamic> json) {
    return Ward(
      wardId: json["wardId"],
      wardNameEn: json["wardNameEn"],
      wardNameUr: json["wardNameUr"],
    );
  }
}

class FeedBackRequestModel {
  FeedBackRequestModel({
    required this.videoFile,
    required this.imageFile,
    required this.audioFile,
    this.name,
    this.email,
    this.phone,
    this.projectId,
    this.complaintFeedbackText,
  });

  final String? name;
  final String? email;
  final String? phone;
  final String? projectId;
  final String? complaintFeedbackText;
  final File? videoFile;
  final File? imageFile;
  final File? audioFile;
}

class GetFeedbackDetailResponse {
  final int id;
  final String nameEn;
  final String nameUr;
  final String email;
  final String phone;
  final String whatsAppPhone;
  final String textMessage;
  final int projectId;
  final List<FeedbackMedia> media;

  GetFeedbackDetailResponse({
    required this.id,
    required this.nameEn,
    required this.nameUr,
    required this.email,
    required this.phone,
    required this.whatsAppPhone,
    required this.textMessage,
    required this.projectId,
    required this.media,
  });

  factory GetFeedbackDetailResponse.fromJson(Map<String, dynamic> json) {
    return GetFeedbackDetailResponse(
      id: json['id'],
      nameEn: json['nameEn'] ?? '',
      nameUr: json['nameUr'] ?? '',
      email: json['email'] ?? '',
      phone: json['phone'] ?? '',
      whatsAppPhone: json['whatsAppPhone'] ?? '',
      textMessage: json['textMessage'] ?? '',
      projectId: json['projectId'],
      media: (json['media'] as List<dynamic>?)
              ?.map((e) => FeedbackMedia.fromJson(e))
              .toList() ??
          [],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'nameEn': nameEn,
      'nameUr': nameUr,
      'email': email,
      'phone': phone,
      'whatsAppPhone': whatsAppPhone,
      'textMessage': textMessage,
      'projectId': projectId,
      'media': media.map((e) => e.toJson()).toList(),
    };
  }
}

class FeedbackMedia {
  final String filePath;
  final String mediaType;
  final String? previewUrl;
  final String? previewUrlI;

  FeedbackMedia({
    required this.filePath,
    required this.mediaType,
    required this.previewUrl,
    required this.previewUrlI,
  });

  factory FeedbackMedia.fromJson(Map<String, dynamic> json) {
    return FeedbackMedia(
      filePath: json['filePath'] ?? '',
      mediaType: json['mediaType'] ?? '',
      previewUrl: json['previewUrl'] ?? '',
      previewUrlI: json['previewUrlI'] ?? '',
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'filePath': filePath,
      'mediaType': mediaType,
      'previewUrl': previewUrl,
      'previewUrlI': previewUrlI,
    };
  }
}

class IsFeedbackAddedResponseModel {
  final bool isfeedbackAdded;

  IsFeedbackAddedResponseModel({
    required this.isfeedbackAdded,
  });

  factory IsFeedbackAddedResponseModel.fromJson(Map<String, dynamic> json) {
    return IsFeedbackAddedResponseModel(
      isfeedbackAdded: json['isfeedbackAdded'] ?? false,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'isfeedbackAdded': isfeedbackAdded,
    };
  }
}
