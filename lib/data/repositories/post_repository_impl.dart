import 'package:dartz/dartz.dart';
import 'package:social_media_block_demo/core/error/failures.dart';
import 'package:social_media_block_demo/core/network/network_info.dart';
import 'package:social_media_block_demo/data/data_sources/remote_data_source.dart';
import 'package:social_media_block_demo/domain/entities/post_entity.dart';
import 'package:social_media_block_demo/domain/repositories/post_repository.dart';

import '../../core/error/exceptions.dart';

class PostRepositoryImpl implements PostRepository {
  final RemoteDataSource remoteDataSource;
  final NetworkInfo networkInfo;

  PostRepositoryImpl({required this.remoteDataSource, required this.networkInfo});

  @override
  Future<Either<Failure, List<PostEntity>>> getPosts(Map<String, dynamic> body) async {
    if (await networkInfo.isConnected) {
      try {
        final postList = await remoteDataSource.getPosts(body);
        return Right(postList);
      } on ValidationException catch (e) {
        return Left(ValidationFailure(errors: e.errors, message: e.message));
      } on ServerException catch (e) {
        return Left(ServerFailure(statusCode: e.statusCode, message: e.message));
      }
    } else {
      return Left(NetworkFailure());
    }
  }
}
