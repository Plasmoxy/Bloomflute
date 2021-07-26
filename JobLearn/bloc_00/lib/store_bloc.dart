import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/cupertino.dart';

@immutable
class StoreState extends Equatable {
  final String user;
  final String pass;

  const StoreState({
    this.user = '',
    this.pass = '',
  });

  factory StoreState.copy(StoreState s, {String? user, String? pass}) => StoreState(
        user: user ?? s.user,
        pass: pass ?? s.pass,
      );

  @override
  List<Object> get props => [user, pass];
}

class StoreCubit extends Cubit<StoreState> {
  StoreCubit() : super(StoreState());

  void setPass(String p) => emit(StoreState.copy(state, pass: p));
  void setUser(String name) => emit(StoreState.copy(state, user: name));
}
