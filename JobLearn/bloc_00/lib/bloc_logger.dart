import 'package:bloc/bloc.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class BlocLogger extends BlocObserver {
  final BuildContext ctx;

  BlocLogger({required this.ctx}) : super();

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
