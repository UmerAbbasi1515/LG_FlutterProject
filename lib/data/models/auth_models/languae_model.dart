
class Language {
  Language({
    this.langId,
    this.title,
  });

  int? langId;
  String? title;

  factory Language.fromJson(Map<String?, dynamic> json) => Language(
        langId: json["langId"],
        title: json["title"],
      );

  Map<String?, dynamic> toJson() => {
        "langId": langId,
        "title": title,
      };
}
