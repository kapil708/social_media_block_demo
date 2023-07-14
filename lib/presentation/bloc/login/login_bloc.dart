import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../core/error/failures.dart';
import '../../../../data/data_sources/local_data_source.dart';
import '../../../../domain/usecases/login_usecase.dart';

part 'login_event.dart';
part 'login_state.dart';

class LoginBloc extends Bloc<LoginEvent, LoginState> {
  final LoginUseCase loginUseCase;
  final LocalDataSource localDataSource;

  TextEditingController txtUserName = TextEditingController();
  TextEditingController txtPassword = TextEditingController();

  LoginBloc({required this.loginUseCase, required this.localDataSource}) : super(LoginStateInitial()) {
    on<LoginClick>((event, emit) async {
      try {
        emit(LoginStateLoading());

        //String userName = event.userName;
        //String password = event.password;

        var formData = {
          "username": event.userName,
          "password": event.password,
        };

        final response = await loginUseCase.call(formData);

        response.fold(
          (failure) => emit(LoginStateException(_mapFailureToMessage(failure))),
          (data) {
            String authToken = data.token;
            localDataSource.cacheAuthToken(authToken);
            emit(LoginStateSuccess());
          },
        );

        //print("::: userName: $userName, password: $password");

        /*await Future.delayed(const Duration(seconds: 5));
        if (userName == 'kapil@pinetco.in' && password == 'password') {
          print("::: LoginStateSuccess");
          emit(LoginStateSuccess());
        } else {
          print("::: LoginStateFailed");
          emit(LoginStateFailed("Invalid login details"));
        }*/
      } on Exception catch (e) {
        emit(LoginStateException(e.toString()));
      }
    });
  }

  String _mapFailureToMessage(Failure failure) {
    switch (failure.runtimeType) {
      case ServerFailure:
        return (failure as ServerFailure).message;
      case CacheFailure:
        return 'cacheFailureMessage';
      default:
        return 'Unexpected error';
    }
  }
}
