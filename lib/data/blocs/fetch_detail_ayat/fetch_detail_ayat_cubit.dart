import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

part 'fetch_detail_ayat_state.dart';

class FetchDetailAyatCubit extends Cubit<FetchDetailAyatState> {
  FetchDetailAyatCubit() : super(FetchDetailAyatInitial());
}
