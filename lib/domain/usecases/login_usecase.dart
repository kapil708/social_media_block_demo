import 'package:dartz/dartz.dart';
import 'package:social_media_block_demo/core/error/failures.dart';
import 'package:social_media_block_demo/domain/entities/login_entity.dart';
import 'package:social_media_block_demo/domain/repositories/user_repository.dart';

class LoginUseCase {
  final UserRepository userRepository;

  LoginUseCase({required this.userRepository});

  Future<Either<Failure, LoginEntity>> call(Map<String, dynamic> body) async {
    return userRepository.login(body);
  }
}
