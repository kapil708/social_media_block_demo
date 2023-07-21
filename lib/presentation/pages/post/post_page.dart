import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:infinite_scroll_pagination/infinite_scroll_pagination.dart';
import 'package:social_media_block_demo/domain/entities/post_entity.dart';
import 'package:social_media_block_demo/injection_container.dart';
import 'package:social_media_block_demo/presentation/bloc/post/post_bloc.dart';

class PostPage extends StatelessWidget {
  const PostPage({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider<PostBloc>(
      create: (_) => locator.get<PostBloc>(),
      child: const PostView(),
    );
  }
}

class PostView extends StatefulWidget {
  const PostView({super.key});

  @override
  State<PostView> createState() => _PostViewState();
}

class _PostViewState extends State<PostView> {
  final PagingController<int, PostEntity> postPagingController = PagingController(firstPageKey: 0);

  @override
  void initState() {
    super.initState();

    postPagingController.addPageRequestListener((pageKey) {
      context.read<PostBloc>().add(PostLoading(pageKey));
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Posts")),
      body: BlocConsumer<PostBloc, PostState>(
        listener: (context, state) {
          if (state is PostExceptionState) {
            postPagingController.error = state.message ?? "Something went wrong. Try again after some time";
          } else if (state is PostFailedState) {
            postPagingController.error = state.message ?? "Something went wrong. Try again after some time";
          } else if (state is PostLoadedState) {
            if (state.postList.length < 15) {
              postPagingController.appendLastPage(state.postList);
            } else {
              final nextPageKey = state.pageKey + state.postList.length;
              postPagingController.appendPage(state.postList, nextPageKey);
            }
          }
        },
        builder: (context, state) {
          return RefreshIndicator(
            onRefresh: () async {},
            child: PagedListView.separated(
              pagingController: postPagingController,
              padding: const EdgeInsets.all(16),
              separatorBuilder: (context, index) => const SizedBox(height: 16),
              builderDelegate: PagedChildBuilderDelegate<PostEntity>(
                itemBuilder: (context, post, index) => Container(
                  child: Column(
                    children: [
                      Text(
                        post.description ?? 'No Description',
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                      ),
                    ],
                  ),
                ),
                firstPageErrorIndicatorBuilder: (context) => const Text("First page error"),
                noItemsFoundIndicatorBuilder: (context) => const Text("No item found"),
              ),
            ),
          );

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
