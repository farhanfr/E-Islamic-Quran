import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

part 'fetch_all_surah_state.dart';

class FetchAllSurahCubit extends Cubit<FetchAllSurahState> {
  FetchAllSurahCubit() : super(FetchAllSurahInitial());
}
