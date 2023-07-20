import 'package:dartz/dartz.dart';
import 'package:social_media_block_demo/core/error/failures.dart';

import '../entities/post_entity.dart';

abstract class PostRepository {
  Future<Either<Failure, List<PostEntity>>> getPosts(Map<String, dynamic> body);
}
