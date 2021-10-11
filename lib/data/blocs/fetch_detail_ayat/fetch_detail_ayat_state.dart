part of 'fetch_detail_ayat_cubit.dart';

abstract class FetchDetailAyatState extends Equatable {
  const FetchDetailAyatState();

  @override
  List<Object> get props => [];
}

class FetchDetailAyatInitial extends FetchDetailAyatState {}


class FetchDetailAyatLoading extends FetchDetailAyatState {}

class FetchDetailAyatSuccess extends FetchDetailAyatState {
  FetchDetailAyatSuccess(this.data);

  final Ayat data;

  @override
  List<Object> get props => [data];
}

class FetchDetailAyatFailure extends FetchDetailAyatState {
  final ErrorType type;
  final String message;

  FetchDetailAyatFailure({this.type = ErrorType.general, this.message});

  FetchDetailAyatFailure.network(String message): this(type: ErrorType.network, message: message);
  FetchDetailAyatFailure.general(String message): this(type: ErrorType.general, message: message);

  @override
  List<Object> get props => [message];
}

