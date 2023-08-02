import 'package:go_router/go_router.dart';
import 'package:social_media_block_demo/presentation/pages/home/home_page.dart';
import 'package:social_media_block_demo/presentation/pages/login/login_page.dart';
import 'package:social_media_block_demo/presentation/pages/post/post_page.dart';
import 'package:social_media_block_demo/presentation/pages/splash_page.dart';

import '../../data/data_sources/local_data_source.dart';
import '../../injection_container.dart';
import '../../presentation/pages/page_404.dart';
import 'route_names.dart';

final LocalDataSource localDatSource = locator.get<LocalDataSource>();

class AppRouter {
  final GoRouter router = GoRouter(
    errorBuilder: (context, state) => const Page404(),
    redirect: (context, state) async {
      print("state.path: ${state.location}");
      if (state.location != '/' && state.location != '/login') {
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
        builder: (context, state) => const SplashPage(),
      ),
      GoRoute(
        path: '/login',
        name: RouteNames.login,
        builder: (context, state) => const LoginPage(),
      ),
      GoRoute(
        path: '/home',
        name: RouteNames.home,
        builder: (context, state) {
          var id = state.queryParameters['id'] ?? '1';
          var userName = state.queryParameters['userName'] ?? 'Kapil';

          return HomePage(id: id, userName: userName);
        },
        routes: [
          GoRoute(
            path: 'post',
            name: RouteNames.post,
            builder: (context, state) => const PostPage(),
          ),
        ],
      ),
    ],
  );
}
