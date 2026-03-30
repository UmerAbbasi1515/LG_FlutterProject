

class CountryPickerModel {
  CountryPickerModel({
    this.countries,
  });

  List<Country>? countries;

  factory CountryPickerModel.fromJson(Map<String?, dynamic> json) =>
      CountryPickerModel(
        countries: List<Country>.from(
            json["countries"].map((x) => Country.fromJson(x))),
      );
}

class Country {
  Country({
    this.countryId,
    this.countryName,
    this.countryCode,
    this.dialingCode,
    this.flag,
  });

  int? countryId;
  String? countryName;
  String? countryCode;
  String? dialingCode;
  String? flag;

  factory Country.fromJson(Map<String?, dynamic> json) => Country(
        countryId: json["countryId"],
        countryName: json["countryName"],
        countryCode: json["countryCode"],
        dialingCode: json["dialingCode"],
        flag: json["flag"],
      );

  Map<String?, dynamic> toJson() => {
        "countryId": countryId,
        "countryName": countryName,
        "countryCode": countryCode,
        "dialingCode": dialingCode,
        "flag": flag,
      };
}
