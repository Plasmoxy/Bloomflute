import 'package:bloc/bloc.dart';

// cubitttt
class CounterCubit extends Cubit<int> {
  CounterCubit(int initialState) : super(initialState);
  void increment() => emit(state + 1);
}
