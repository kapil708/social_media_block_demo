import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:social_media_block_demo/presentation/pages/home/home_page.dart';
import 'package:social_media_block_demo/presentation/pages/login/login_page.dart';
import 'package:social_media_block_demo/presentation/pages/page_404.dart';
import 'package:social_media_block_demo/presentation/pages/splash_page.dart';

import '../../data/data_sources/local_data_source.dart';
import '../../injection_container.dart';
import 'route_names.dart';

final LocalDataSource localDatSource = locator.get<LocalDataSource>();

class AppRouter {
  final GoRouter router = GoRouter(
    errorBuilder: (context, state) => const Page404(),
    redirect: (context, state) async {
      print("state.path: ${state.location}");
      if (state.location != '/') {
        bool isLogin = await localDatSource.isLogin();
        return isLogin ? null : '/login';
      } else {
        return null;
      }
    },
    routes: [
      GoRoute(
        path: '/',
        name: RouteNames.splash,
        builder: (BuildContext context, GoRouterState state) => const SplashPage(),
      ),
      GoRoute(
        path: '/login',
        name: RouteNames.login,
        builder: (BuildContext context, GoRouterState state) => const LoginPage(),
      ),
      GoRoute(
        path: '/home/:userName',
        name: RouteNames.home,
        builder: (BuildContext context, GoRouterState state) {
          var id = state.queryParameters['id']!;
          var userName = state.pathParameters['userName']!;

          return HomePage(id: id, userName: userName);
        },
      ),
    ],
  );
}
