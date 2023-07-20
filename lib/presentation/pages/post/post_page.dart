import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:social_media_block_demo/injection_container.dart';
import 'package:social_media_block_demo/presentation/bloc/post/post_bloc.dart';

class PostPage extends StatelessWidget {
  const PostPage({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider<PostBloc>(
      create: (context) => locator.get<PostBloc>()..add(PostLoading()),
      child: const PostView(),
    );
  }
}

class PostView extends StatelessWidget {
  const PostView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Posts")),
      body: BlocConsumer<PostBloc, PostState>(
        listener: (context, state) {},
        builder: (context, state) {
          return Column(
            children: [
              const Text("Post"),
              if (state is PostLoadingState) const CircularProgressIndicator(),
            ],
          );
        },
      ),
    );
  }
}
