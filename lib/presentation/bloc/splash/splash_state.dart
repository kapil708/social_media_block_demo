part of 'splash_bloc.dart';

@immutable
abstract class SplashState extends Equatable {}

class SplashInitial extends SplashState {
  @override
  List<Object?> get props => [];
}

class SplashLoginChecked extends SplashState {
  final bool isLogin;

  SplashLoginChecked(this.isLogin);

  @override
  List<Object?> get props => [];
}
