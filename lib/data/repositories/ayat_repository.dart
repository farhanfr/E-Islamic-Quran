import 'dart:io';

import 'package:e_islamic_quran/api/api.dart';
import 'package:e_islamic_quran/data/models/ayat.dart';
import 'package:flutter/cupertino.dart';

class AyatRepository{
  final ApiProvider _provider = ApiProvider();

  Future<AyatResponse> getDetailAyat({@required int surahNumber,@required int ayatNumber}) async {
    final response = await _provider.get("/surah/$surahNumber/$ayatNumber", headers: {
      // HttpHeaders.authorizationHeader: 'Bearer $_token',
      HttpHeaders.contentTypeHeader: 'application/json',
    });
    return AyatResponse.fromJson(response);
  }
}