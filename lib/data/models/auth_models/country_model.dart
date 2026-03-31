
class Country {
  Country({
    this.id,
    this.nameEn,
    this.nameUr,
    this.dialingCode,
    this.flag,
    this.active,
  });

  int? id;
  String? nameEn;
  String? nameUr;
  String? dialingCode;
  String? flag;
  bool? active;

  factory Country.fromJson(Map<String?, dynamic> json) => Country(
        id: json["id"],
        nameEn: json["nameEn"],
        nameUr: json["nameUr"],
        dialingCode: json["dialingCode"],
        flag: json["flag"],
        active: json["active"],
      );

  Map<String?, dynamic> toJson() => {
        "id": id,
        "nameEn": nameEn,
        "nameUr": nameUr,
        "dialingCode": dialingCode,
        "flag": flag,
        "active": active,
      };
}
