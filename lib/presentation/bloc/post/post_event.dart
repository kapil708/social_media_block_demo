part of 'post_bloc.dart';

@immutable
abstract class PostEvent extends Equatable {}

class PostLoading extends PostEvent {
  @override
  List<Object?> get props => [];
}
