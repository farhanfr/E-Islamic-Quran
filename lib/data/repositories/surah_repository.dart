import 'dart:io';

import 'package:e_islamic_quran/api/api.dart';
import 'package:e_islamic_quran/data/models/models.dart';

class SurahRepository{
  final ApiProvider _provider = ApiProvider();

  Future<SurahResponse> getAllSurah() async {
    final response = await _provider.get("/surah", headers: {
      // HttpHeaders.authorizationHeader: 'Bearer $_token',
      HttpHeaders.contentTypeHeader: 'application/json',
    });
    return SurahResponse.fromJson(response);
  }

  Future<DetailSurahResponse> getDetailSurah(int id) async {
    final response = await _provider.get("/surah/$id", headers: {
      // HttpHeaders.authorizationHeader: 'Bearer $_token',
      HttpHeaders.contentTypeHeader: 'application/json',
    });
    return DetailSurahResponse.fromJson(response);
  }


}