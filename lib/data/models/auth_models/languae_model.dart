
class Language {
  Language({
    this.id,
    this.nameEn,
    this.active,
  });

  int? id;
  String? nameEn;
  bool? active;

  factory Language.fromJson(Map<String?, dynamic> json) => Language(
        id: json["id"],
        nameEn: json["nameEn"],
        active: json["active"],
      );

  Map<String?, dynamic> toJson() => {
        "id": id,
        "nameEn": nameEn,
        "active": active,
      };
}
