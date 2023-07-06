import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';

import '../../core/route/route_names.dart';
import '../logic/bloc/splash/splash_bloc.dart';

class SplashPage extends StatelessWidget {
  const SplashPage({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => SplashBloc()..add(SplashLoginCheck()),
      child: const SplashView(),
    );

    return const SplashView();
  }
}

class SplashView extends StatelessWidget {
  const SplashView({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocListener<SplashBloc, SplashState>(
      listener: (context, state) {
        if (state is SplashLoginChecked) {
          if (state.isLogin == true) {
            String userName = "Kapil R Singh";
            String id = "101";
            context.goNamed(RouteNames.home, pathParameters: {"userName": userName}, queryParameters: {'id': id});
          } else {
            context.go('/login');
          }
        }
      },
      child: Scaffold(
        body: SizedBox(
          width: MediaQuery.of(context).size.width,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Icon(
                Icons.heart_broken,
                size: 150,
                color: Colors.red,
              ),
              Text(
                "The Social",
                style: Theme.of(context).textTheme.headlineLarge,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
