part of 'fetch_all_surah_cubit.dart';

abstract class FetchAllSurahState extends Equatable {
  const FetchAllSurahState();

  @override
  List<Object> get props => [];
}

class FetchAllSurahInitial extends FetchAllSurahState {}

class FetchAllSurahLoading extends FetchAllSurahState {}

class FetchAllSurahSuccess extends FetchAllSurahState {
  // FetchAllSurahSuccess(this.data);

  // final Type data;

  // @override
  // List<Object> get props => [data];
}

class FetchAllSurahFailure extends FetchAllSurahState {
  FetchAllSurahFailure(this.message);

  final String message;

  @override
  List<Object> get props => [message];
}

