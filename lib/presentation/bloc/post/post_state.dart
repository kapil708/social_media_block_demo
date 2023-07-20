part of 'post_bloc.dart';

@immutable
abstract class PostState extends Equatable {}

class PostInitial extends PostState {
  @override
  List<Object?> get props => [];
}

class PostLoadingState extends PostState {
  @override
  List<Object?> get props => [];
}

class PostFailedState extends PostState {
  final String? message;

  PostFailedState(this.message);

  @override
  List<Object?> get props => [message];
}

class PostExceptionState extends PostState {
  final String? message;

  PostExceptionState(this.message);

  @override
  List<Object?> get props => [message];
}

class PostLoadedState extends PostState {
  final int pageKey;
  final List<PostEntity> postList;

  PostLoadedState(this.pageKey, this.postList);

  @override
  List<Object?> get props => [postList];
}
