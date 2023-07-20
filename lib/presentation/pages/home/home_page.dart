import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:social_media_block_demo/core/route/route_names.dart';

class HomePage extends StatelessWidget {
  final String id;
  final String userName;
  const HomePage({super.key, required this.id, required this.userName});

  @override
  Widget build(BuildContext context) {
    return HomeView(userName: userName, id: id);
  }
}

class HomeView extends StatelessWidget {
  final String id;
  final String userName;
  const HomeView({super.key, required this.id, required this.userName});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Home')),
      body: Container(
        padding: const EdgeInsets.all(16),
        child: Column(
          children: [
            Text(
              "Hi, $userName \nWelcome to home. Your id is $id",
              style: Theme.of(context).textTheme.titleLarge,
            ),
            const SizedBox(height: 16),
            ElevatedButton(
              onPressed: () => context.goNamed(RouteNames.post),
              child: const Text("Go to post screen"),
            ),
          ],
        ),
      ),
    );
  }
}
