import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:social_media_block_demo/domain/entities/post_entity.dart';
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
        listener: (context, state) {
          if (state is PostExceptionState) {
            print("PostExceptionState: ${state.message}");
          } else if (state is PostFailedState) {
            print("PostFailedState: ${state.message}");
          } else if (state is PostLoadedState) {
            print("PostLoadedState: ${state.postList.length}");
          }
        },
        builder: (context, state) {
          return SingleChildScrollView(
            child: Column(
              children: [
                if (state is PostLoadingState) const CircularProgressIndicator(),
                if (state is PostLoadedState)
                  ListView.builder(
                    itemCount: state.postList.length,
                    physics: const NeverScrollableScrollPhysics(),
                    shrinkWrap: true,
                    itemBuilder: (context, index) {
                      PostEntity post = state.postList[index];
                      return ListTile(
                        title: Text(
                          post.description ?? 'No Description',
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                        ),
                      );
                    },
                  ),
              ],
            ),
          );
        },
      ),
    );
  }
}
