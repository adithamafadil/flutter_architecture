import 'package:freezed_annotation/freezed_annotation.dart';

part 'view_data_state.freezed.dart';

@freezed
class ViewDataState<Data> with _$ViewDataState<Data> {
  const factory ViewDataState.initial() = _ViewDataStateInitial<Data>;

  const factory ViewDataState.loading() = _ViewDataStateLoading<Data>;

  const factory ViewDataState.success({required Data data}) =
      _ViewDataStateSuccess<Data>;

  const factory ViewDataState.error({
    required String message,
    Data? data,
  }) = _ViewDataStateError<Data>;
}
