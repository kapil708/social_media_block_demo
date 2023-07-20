import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../domain/entities/post_entity.dart';
import '../../../domain/usecases/post_usecases.dart';

part 'post_event.dart';
part 'post_state.dart';

class PostBloc extends Bloc<PostEvent, PostState> {
  final PostUseCase postUseCase;

  PostBloc({required this.postUseCase}) : super(PostInitial()) {
    on<PostLoading>((event, emit) async {
      try {
        emit(PostLoadingState());

        var formData = {
          'skip': event.pageKey,
          'take': 15,
        };

        final response = await postUseCase.call(formData);

        response.fold(
          (failure) => emit(PostFailedState('Failed')),
          (data) => emit(PostLoadedState(event.pageKey, data)),
        );
      } on Exception catch (e) {
        emit(PostExceptionState(e.toString()));
      }
    });
  }
}
