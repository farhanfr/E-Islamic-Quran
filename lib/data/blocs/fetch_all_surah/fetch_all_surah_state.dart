part of 'fetch_all_surah_cubit.dart';

abstract class FetchAllSurahState extends Equatable {
  const FetchAllSurahState();

  @override
  List<Object> get props => [];
}

class FetchAllSurahInitial extends FetchAllSurahState {}

class FetchAllSurahLoading extends FetchAllSurahState {}

class FetchAllSurahSuccess extends FetchAllSurahState {
  FetchAllSurahSuccess(this.surah);

  final List<Surah> surah;

  @override
  List<Object> get props => [surah];
}

class FetchAllSurahFailure extends FetchAllSurahState {
  final ErrorType type;
  final String message;

  FetchAllSurahFailure({this.type = ErrorType.general, this.message});

  FetchAllSurahFailure.network(String message): this(type: ErrorType.network, message: message);
  FetchAllSurahFailure.general(String message): this(type: ErrorType.general, message: message);

  @override
  List<Object> get props => [message];
}

