import 'package:bloc/bloc.dart';
import 'package:e_islamic_quran/api/api.dart';
import 'package:e_islamic_quran/data/models/ayat.dart';
import 'package:e_islamic_quran/data/models/models.dart';
import 'package:e_islamic_quran/data/repositories/ayat_repository.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/foundation.dart';

part 'fetch_detail_ayat_state.dart';

class FetchDetailAyatCubit extends Cubit<FetchDetailAyatState> {
  FetchDetailAyatCubit() : super(FetchDetailAyatInitial());

  final AyatRepository _ayatRepository = AyatRepository();
  
  Future<void> fetchDetailAyat({@required int surahNumber,@required int ayatNumber}) async {
    emit(FetchDetailAyatLoading());
    try {
      final response = await _ayatRepository.getDetailAyat(surahNumber: surahNumber, ayatNumber: ayatNumber);
      // await Future.delayed(Duration(seconds: 1));
      emit(FetchDetailAyatSuccess(response.data));
    } catch (error) {
      emit(FetchDetailAyatFailure());
    }
  }
  
  
}
