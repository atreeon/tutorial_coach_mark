import 'package:flutter_bloc/flutter_bloc.dart';

class CounterState {
  const CounterState({
    required this.count,
    required this.textValue,
    required this.isTextFieldHidden,
  });

  final int count;
  final String textValue;
  final bool isTextFieldHidden;

  CounterState copyWith({
    int? count,
    String? textValue,
    bool? isTextFieldHidden,
  }) {
    return CounterState(
      count: count ?? this.count,
      textValue: textValue ?? this.textValue,
      isTextFieldHidden: isTextFieldHidden ?? this.isTextFieldHidden,
    );
  }
}

class CounterCubit extends Cubit<CounterState> {
  CounterCubit()
      : super(const CounterState(
          count: 0,
          textValue: '',
          isTextFieldHidden: true,
        ));

  void increment() => emit(state.copyWith(count: state.count + 1));

  void updateText(String value) => emit(state.copyWith(textValue: value));

  void toggleTextFieldVisibility() => emit(
        state.copyWith(isTextFieldHidden: !state.isTextFieldHidden),
      );

  void setTextFieldHidden(bool hidden) =>
      emit(state.copyWith(isTextFieldHidden: hidden));
}
