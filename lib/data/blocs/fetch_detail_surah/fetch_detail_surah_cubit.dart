import 'package:bloc/bloc.dart';
import 'package:e_islamic_quran/api/api.dart';
import 'package:e_islamic_quran/data/models/models.dart';
import 'package:e_islamic_quran/data/repositories/repositories.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/cupertino.dart';

part 'fetch_detail_surah_state.dart';

class FetchDetailSurahCubit extends Cubit<FetchDetailSurahState> {
  FetchDetailSurahCubit() : super(FetchDetailSurahInitial());

  final SurahRepository _surahRepository = SurahRepository();

  Future<void> fetchDetailSurah({@required int id}) async {
    emit(FetchDetailSurahLoading());
    try {
      final response = await _surahRepository.getDetailSurah(id);
      emit(FetchDetailSurahSuccess(response.data));
    } catch (error) {
      if (error is NetworkException) {
        emit(FetchDetailSurahFailure.network(error.toString()));
        return;
      }
      emit(FetchDetailSurahFailure.general(error.toString()));
    }
  }
}
