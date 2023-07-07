import 'package:dartz/dartz.dart';
import 'package:social_media_block_demo/core/error/failures.dart';
import 'package:social_media_block_demo/domain/entities/login_entity.dart';
import 'package:social_media_block_demo/domain/repositories/user_repository.dart';

class PostLogin {
  final UserRepository userRepository;

  PostLogin(this.userRepository);

  Future<Either<Failure, LoginEntity>> call({required String userName, required String password}) async {
    return userRepository.login(userName: userName, password: password);
  }
}
