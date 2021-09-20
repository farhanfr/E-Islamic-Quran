part of 'fetch_detail_surah_cubit.dart';

abstract class FetchDetailSurahState extends Equatable {
  const FetchDetailSurahState();

  @override
  List<Object> get props => [];
}

class FetchDetailSurahInitial extends FetchDetailSurahState {}

class FetchDetailSurahLoading extends FetchDetailSurahState {}

class FetchDetailSurahSuccess extends FetchDetailSurahState {
  FetchDetailSurahSuccess(this.detailSurah);

  final Surah detailSurah;

  @override
  List<Object> get props => [detailSurah];
}

class FetchDetailSurahFailure extends FetchDetailSurahState {
  final ErrorType type;
  final String message;

  FetchDetailSurahFailure({this.type = ErrorType.general, this.message});

  FetchDetailSurahFailure.network(String message)
      : this(type: ErrorType.network, message: message);
  FetchDetailSurahFailure.general(String message)
      : this(type: ErrorType.general, message: message);

  @override
  List<Object> get props => [message];
}
