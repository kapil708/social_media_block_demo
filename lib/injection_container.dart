import 'package:get_it/get_it.dart';
import 'package:http/http.dart' as http;
import 'package:internet_connection_checker_plus/internet_connection_checker_plus.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'core/network/network_info.dart';
import 'data/data_sources/local_data_source.dart';
import 'data/data_sources/remote_data_source.dart';
import 'data/repositories/post_repository_impl.dart';
import 'data/repositories/user_repository_impl.dart';
import 'domain/repositories/post_repository.dart';
import 'domain/repositories/user_repository.dart';
import 'domain/usecases/login_usecase.dart';
import 'domain/usecases/post_usecases.dart';
import 'presentation/bloc/login/login_bloc.dart';
import 'presentation/bloc/post/post_bloc.dart';

final GetIt locator = GetIt.instance;

Future<void> setUp() async {
  // Features
  locator.registerFactory(() => LoginBloc(loginUseCase: locator(), localDataSource: locator()));
  locator.registerFactory(() => PostBloc(postUseCase: locator()));

  // Use Case
  locator.registerLazySingleton(() => LoginUseCase(userRepository: locator()));
  locator.registerLazySingleton(() => PostUseCase(postRepository: locator()));

  // Repository
  locator.registerLazySingleton<UserRepository>(() => UserRepositoryImpl(remoteDataSource: locator(), networkInfo: locator()));
  locator.registerLazySingleton<PostRepository>(() => PostRepositoryImpl(remoteDataSource: locator(), networkInfo: locator()));

  // Data source
  locator.registerLazySingleton<RemoteDataSource>(() => RemoteDataSourceImpl(client: locator()));
  locator.registerLazySingleton<LocalDataSource>(() => LocalDataSourceImpl(sharedPreferences: locator()));

  // Core
  locator.registerLazySingleton<NetworkInfo>(() => NetworkInfoImpl(internetConnection: locator()));

  // External
  final sharedPreferences = await SharedPreferences.getInstance();
  locator.registerLazySingleton(() => sharedPreferences);
  locator.registerLazySingleton(() => http.Client());
  locator.registerLazySingleton(() => InternetConnection());
}
