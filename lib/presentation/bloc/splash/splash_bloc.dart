import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../data/data_sources/local_data_source.dart';
import '../../../injection_container.dart';

part 'splash_event.dart';
part 'splash_state.dart';

class SplashBloc extends Bloc<SplashEvent, SplashState> {
  SplashBloc() : super(SplashInitial()) {
    on<SplashLoginCheck>((event, emit) async {
      await Future.delayed(const Duration(seconds: 2));

      bool isLogin = await locator.get<LocalDataSource>().isLogin();

      emit(SplashLoginChecked(isLogin));
    });
  }
}
