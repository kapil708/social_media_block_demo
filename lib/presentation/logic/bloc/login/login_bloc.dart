import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

part 'login_event.dart';
part 'login_state.dart';

class LoginBloc extends Bloc<LoginEvent, LoginState> {
  TextEditingController txtUserName = TextEditingController();
  TextEditingController txtPassword = TextEditingController();

  LoginBloc() : super(LoginStateInitial()) {
    on<LoginClick>((event, emit) async {
      try {
        emit(LoginStateLoading());

        String userName = event.userName;
        String password = event.password;

        print("::: userName: $userName, password: $password");

        await Future.delayed(const Duration(seconds: 5));
        if (userName == 'kapil@pinetco.in' && password == 'password') {
          print("::: LoginStateSuccess");
          emit(LoginStateSuccess());
        } else {
          print("::: LoginStateFailed");
          emit(LoginStateFailed("Invalid login details"));
        }
      } on Exception catch (e) {
        emit(LoginStateException(e.toString()));
      }
    });
  }
}
