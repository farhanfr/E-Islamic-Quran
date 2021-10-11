import 'package:e_islamic_quran/data/models/surah.dart';

class AyatResponse{
  AyatResponse({
        this.code,
        this.status,
        this.message,
        this.data,
  });

  int code;
  String status;
  String message;
  Ayat data;

  factory AyatResponse.fromJson(Map<String, dynamic> json) => AyatResponse(
        code: json["code"],
        status: json["status"],
        message: json["message"],
        data: Ayat.fromJson(json["data"]),
    );

    Map<String, dynamic> toJson() => {
        "code": code,
        "status": status,
        "message": message,
        "data": data.toJson(),
    };

}

class Ayat{
  Ayat({
        this.number,
        this.meta,
        this.text,
        this.translation,
        this.audio,
        this.tafsir,
        this.surah,
    });

    NumberAyat number;
    MetaAyat meta;
    TextAyat text;
    Translation translation;
    Audio audio;
    TafsirAyat tafsir;
    Surah surah;

    factory Ayat.fromJson(Map<String, dynamic> json) => Ayat(
        number: NumberAyat.fromJson(json["number"]),
        meta: MetaAyat.fromJson(json["meta"]),
        text: TextAyat.fromJson(json["text"]),
        translation: Translation.fromJson(json["translation"]),
        audio: Audio.fromJson(json["audio"]),
        tafsir: TafsirAyat.fromJson(json["tafsir"]),
        surah: Surah.fromJson(json["surah"]),
    );

    Map<String, dynamic> toJson() => {
        "number": number.toJson(),
        "meta": meta.toJson(),
        "text": text.toJson(),
        "translation": translation.toJson(),
        "audio": audio.toJson(),
        "tafsir": tafsir.toJson(),
        "surah": surah.toJson(),
    };

}

class NumberAyat {
  NumberAyat({
        this.inQuran,
        this.inSurah,
    });

    int inQuran;
    int inSurah;

    factory NumberAyat.fromJson(Map<String, dynamic> json) => NumberAyat(
        inQuran: json["inQuran"],
        inSurah: json["inSurah"],
    );

    Map<String, dynamic> toJson() => {
        "inQuran": inQuran,
        "inSurah": inSurah,
    };
}

class MetaAyat {
  MetaAyat({
        this.juz,
        this.page,
        this.manzil,
        this.ruku,
        this.hizbQuarter,
    });

    int juz;
    int page;
    int manzil;
    int ruku;
    int hizbQuarter;

    factory MetaAyat.fromJson(Map<String, dynamic> json) => MetaAyat(
        juz: json["juz"],
        page: json["page"],
        manzil: json["manzil"],
        ruku: json["ruku"],
        hizbQuarter: json["hizbQuarter"],
    );

    Map<String, dynamic> toJson() => {
        "juz": juz,
        "page": page,
        "manzil": manzil,
        "ruku": ruku,
        "hizbQuarter": hizbQuarter,
    };
}

class TextAyat {
  TextAyat({
        this.arab,
        this.transliteration,
    });

    String arab;
    Transliteration transliteration;

    factory TextAyat.fromJson(Map<String, dynamic> json) => TextAyat(
        arab: json["arab"],
        transliteration: Transliteration.fromJson(json["transliteration"]),
    );

    Map<String, dynamic> toJson() => {
        "arab": arab,
        "transliteration": transliteration.toJson(),
    };
}

//ChildClass of TextAyat
class Transliteration {
    Transliteration({
        this.en,
    });

    String en;

    factory Transliteration.fromJson(Map<String, dynamic> json) => Transliteration(
        en: json["en"],
    );

    Map<String, dynamic> toJson() => {
        "en": en,
    };
}

class Audio {
  Audio({
        this.primary,
        this.secondary,
    });

    String primary;
    List<String> secondary;

    factory Audio.fromJson(Map<String, dynamic> json) => Audio(
        primary: json["primary"],
        secondary: List<String>.from(json["secondary"].map((x) => x)),
    );

    Map<String, dynamic> toJson() => {
        "primary": primary,
        "secondary": List<dynamic>.from(secondary.map((x) => x)),
    };
}

class TafsirAyat {
   TafsirAyat({
        this.dataTafsir,
    });

    TypeTafsir dataTafsir;

    factory TafsirAyat.fromJson(Map<String, dynamic> json) => TafsirAyat(
        dataTafsir: TypeTafsir.fromJson(json["id"]),
    );

    Map<String, dynamic> toJson() => {
        "id": dataTafsir.toJson(),
    };
}

//ChildClass of Class TafsirAyat
class TypeTafsir {
  TypeTafsir({
        this.short,
        this.long,
    });

    String short;
    String long;

    factory TypeTafsir.fromJson(Map<String, dynamic> json) => TypeTafsir(
        short: json["short"],
        long: json["long"],
    );

    Map<String, dynamic> toJson() => {
        "short": short,
        "long": long,
    };
}






