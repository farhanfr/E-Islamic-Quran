import 'package:bloc/bloc.dart';
import 'package:e_islamic_quran/api/api.dart';
import 'package:e_islamic_quran/data/models/models.dart';
import 'package:e_islamic_quran/data/repositories/surah_repository.dart';
import 'package:equatable/equatable.dart';

part 'fetch_all_surah_state.dart';

class FetchAllSurahCubit extends Cubit<FetchAllSurahState> {
  FetchAllSurahCubit() : super(FetchAllSurahInitial());

  final SurahRepository _surahRepository = SurahRepository();

  Future<void> fetchAllSurah() async{
    emit(FetchAllSurahLoading());
    try {
      final response = await _surahRepository.getAllSurah();
      emit(FetchAllSurahSuccess(response.data));
    } catch (error) {
      if (error is NetworkException) {
        emit(FetchAllSurahFailure.network(error.toString()));
        return;
      }
      emit(FetchAllSurahFailure.general(error.toString()));

    }

  }
}
