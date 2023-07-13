import 'package:dartz/dartz.dart';
import 'package:social_media_block_demo/core/error/failures.dart';
import 'package:social_media_block_demo/domain/entities/login_entity.dart';

abstract class UserRepository {
  Future<Either<Failure, LoginEntity>> login(Map<String, dynamic> body);
}
