import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:social_media_block_demo/presentaton/pages/home/home_page.dart';
import 'package:social_media_block_demo/presentaton/pages/login/login_page.dart';
import 'package:social_media_block_demo/presentaton/pages/splash_page.dart';

class AppRouter {
  final GoRouter router = GoRouter(
    routes: <RouteBase>[
      GoRoute(
        path: '/',
        builder: (BuildContext context, GoRouterState state) {
          return const SplashPage();
        },
        routes: <RouteBase>[
          GoRoute(
            path: 'login',
            builder: (BuildContext context, GoRouterState state) {
              return const LoginPage();
            },
          ),
          GoRoute(
            path: 'home',
            builder: (BuildContext context, GoRouterState state) {
              return const HomePage();
            },
          ),
        ],
      ),
    ],
    redirect: (context, state) {
      //final bool logginIN = state.sub
    },
  );
}
