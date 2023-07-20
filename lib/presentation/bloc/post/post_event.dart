part of 'post_bloc.dart';

@immutable
abstract class PostEvent extends Equatable {}

class PostLoading extends PostEvent {
  final int pageKey;

  PostLoading(this.pageKey);

  @override
  List<Object?> get props => [];
}
