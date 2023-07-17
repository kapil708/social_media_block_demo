import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

part 'login_with_otp_event.dart';
part 'login_with_otp_state.dart';

class LoginWithOtpBloc extends Bloc<LoginWithOtpEvent, LoginWithOtpState> {
  LoginWithOtpBloc() : super(LoginWithOtpInitial()) {
    on<LoginWithOtpEvent>((event, emit) {
      // TODO: implement event handler
    });
  }
}
