import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

part 'fetch_detail_surah_state.dart';

class FetchDetailSurahCubit extends Cubit<FetchDetailSurahState> {
  FetchDetailSurahCubit() : super(FetchDetailSurahInitial());
}
