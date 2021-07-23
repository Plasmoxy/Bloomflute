import 'package:bloc/bloc.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

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
  final BuildContext ctx;

  CounterBloc({required this.ctx}) : super(0);

  @override
  Stream<int> mapEventToState(CounterEvent event) async* {
    if (event is CounterIncrement) yield state + 1;
    if (event is CounterDecrement) yield state - 1;
    if (event is CounterSlowRise) yield* event.rise(); // custom nested generator call

    if (event is CounterErrorEvent) {
      addError(Exception('Increment error!'));
    }
  }

  /* // triggers twice ?? 
  @override
  void onError(Object error, StackTrace stackTrace) {
    super.onError(error, stackTrace);
    showDialog(
      context: ctx,
      builder: (_) => new CupertinoAlertDialog(
        title: new Text("Cupertino Dialog"),
        content: new Text("Hey! I'm Coflutter!"),
        actions: <Widget>[
          CupertinoButton(
            child: Text('Close me!'),
            onPressed: () {
              Navigator.of(ctx).pop();
            },
          )
        ],
      ),
    );
  }
  */
}
