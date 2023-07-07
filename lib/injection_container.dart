import 'package:get_it/get_it.dart';
import 'package:http/http.dart' as http;
import 'package:internet_connection_checker_plus/internet_connection_checker_plus.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:social_media_block_demo/core/network/network_info.dart';
import 'package:social_media_block_demo/data/data_sources/local_data_source.dart';

import 'data/data_sources/remote_data_source.dart';

final GetIt locator = GetIt.instance;

Future<void> setUp() async {
  // Features

  // Repository

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
