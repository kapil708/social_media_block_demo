import 'package:flutter/material.dart';

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
      body: Column(
        children: [
          Text(
            "Hi, $userName \nWelcome to home. Your id is $id",
            style: Theme.of(context).textTheme.titleLarge,
          ),
        ],
      ),
    );
  }
}
