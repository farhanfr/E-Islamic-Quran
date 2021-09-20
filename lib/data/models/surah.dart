import 'package:flutter/cupertino.dart';

class SurahResponse {
    SurahResponse({
        @required this.code,
        @required this.status,
        @required this.message,
        @required this.data,
    });

    int code;
    String status;
    String message;
    List<Surah> data;

    factory SurahResponse.fromJson(Map<String, dynamic> json) => SurahResponse(
        code: json["code"],
        status: json["status"],
        message: json["message"],
        data: List<Surah>.from(json["data"].map((x) => Surah.fromJson(x))),
    );

    Map<String, dynamic> toJson() => {
        "code": code,
        "status": status,
        "message": message,
        "data": List<dynamic>.from(data.map((x) => x.toJson())),
    };
}

class DetailSurahResponse {
    DetailSurahResponse({
        @required this.code,
        @required this.status,
        @required this.message,
        @required this.data,
    });

    int code;
    String status;
    String message;
    Surah data;

    factory DetailSurahResponse.fromJson(Map<String, dynamic> json) => DetailSurahResponse(
        code: json["code"],
        status: json["status"],
        message: json["message"],
        data: Surah.fromJson(json["data"])
    );

    Map<String, dynamic> toJson() => {
        "code": code,
        "status": status,
        "message": message,
        "data": data.toJson()
    };
}

class Surah{
   Surah({
        this.number,
        this.sequence,
        this.numberOfVerses,
        this.nameSurah,
        this.revelation,
        this.tafsir,
    });
    
    int number;
    int sequence;
    int numberOfVerses;
    NameSurah nameSurah;
    Revelation revelation;
    Tafsir tafsir;

    factory Surah.fromJson(Map<String, dynamic> json) => Surah(
        number: json["number"],
        sequence: json["sequence"],
        numberOfVerses: json["numberOfVerses"],
        nameSurah: NameSurah.fromJson(json["name"]),
        revelation: Revelation.fromJson(json["revelation"]),
        tafsir: Tafsir.fromJson(json["tafsir"]),
    );

    Map<String, dynamic> toJson() => {
        "number": number,
        "sequence": sequence,
        "numberOfVerses": numberOfVerses,
        "name": nameSurah.toJson(),
        "revelation": revelation.toJson(),
        "tafsir": tafsir.toJson(),
    };
}

class NameSurah{
    NameSurah({
        this.short,
        this.long,
        this.transliteration,
        this.translation,
    });
    String short;
    String long;
    Translation transliteration;
    Translation translation;

    factory NameSurah.fromJson(Map<String, dynamic> json) => NameSurah(
        short: json["short"],
        long: json["long"],
        transliteration: Translation.fromJson(json["transliteration"]),
        translation: Translation.fromJson(json["translation"]),
    );

    Map<String, dynamic> toJson() => {
        "short": short,
        "long": long,
        "transliteration": transliteration.toJson(),
        "translation": translation.toJson(),
    };

}

class Revelation {
    Revelation({
        this.arab,
        this.en,
        this.indo,
    });

    String arab;
    String en;
    String indo;

    factory Revelation.fromJson(Map<String, dynamic> json) => Revelation(
        arab: json["arab"],
        en: json["en"],
        indo: json["id"],
    );

    Map<String, dynamic> toJson() => {
        "arab": arab,
        "en": en,
        "id": indo,
    };

}

class Tafsir {
  Tafsir({
    this.indo
  });

  String indo;

  factory Tafsir.fromJson(Map<String, dynamic> json) => Tafsir(
        indo: json["id"],
    );

    Map<String, dynamic> toJson() => {
        "id": indo,
    };

}

class Translation {
  Translation({
        this.en,
        this.indo,
    });

    String en;
    String indo;

    factory Translation.fromJson(Map<String, dynamic> json) => Translation(
        en: json["en"],
        indo: json["id"],
    );

    Map<String, dynamic> toJson() => {
        "en": en,
        "id": indo,
    };
}




