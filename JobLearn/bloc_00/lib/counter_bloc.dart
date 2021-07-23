import 'package:bloc/bloc.dart';

abstract class CounterEvent {}

class CounterIncrement extends CounterEvent {
  final int by;
  CounterIncrement({required this.by});
}

class CounterDecrement extends CounterEvent {
  final int by;
  CounterDecrement({required this.by});
}

class CounterSlowRise extends CounterEvent {
  final int to;
  CounterSlowRise({required this.to});

  // separate generator
  Stream<int> rise() async* {
    for (int i = 0; i <= to; i++) {
      yield i;
      await Future.delayed(Duration(seconds: 1));
    }
  }
}

class CounterErrorEvent extends CounterEvent {}

class CounterBloc extends Bloc<CounterEvent, int> {
  CounterBloc() : super(0);

  @override
  Stream<int> mapEventToState(CounterEvent event) async* {
    if (event is CounterIncrement) yield state + 1;
    if (event is CounterDecrement) yield state - 1;
    if (event is CounterSlowRise) yield* event.rise(); // nested generator call
  }
}

class BlocLogger extends BlocObserver {
  @override
  void onEvent(Bloc bloc, Object? event) {
    super.onEvent(bloc, event);
    print('${bloc.runtimeType} $event');
  }

  @override
  void onTransition(Bloc bloc, Transition transition) {
    super.onTransition(bloc, transition);
    print('${bloc.runtimeType} ${transition.currentState} --[${transition.event.runtimeType})]-> ${transition.nextState}');
  }
}
