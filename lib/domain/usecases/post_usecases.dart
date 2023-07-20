import 'package:dartz/dartz.dart';
import 'package:social_media_block_demo/core/error/failures.dart';
import 'package:social_media_block_demo/domain/entities/post_entity.dart';
import 'package:social_media_block_demo/domain/repositories/post_repository.dart';

class PostUseCase {
  final PostRepository postRepository;

  PostUseCase({required this.postRepository});

  Future<Either<Failure, List<PostEntity>>> call(Map<String, dynamic> body) async {
    return postRepository.getPosts(body);
  }
}
