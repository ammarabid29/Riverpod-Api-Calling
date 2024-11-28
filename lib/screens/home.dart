import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:riverpod_api_calling/models/post.dart';
import 'package:riverpod_api_calling/state/post_state.dart';

class HomeScreen extends ConsumerWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Riverpod Api Calling"),
      ),
      body: Center(
        child: Consumer(builder: (ctx, ref, child) {
          PostState state = ref.watch(postsProvider);
          if (state is InitialPostState) {
            return const Text("Press FAB to Fetch Data");
          }
          if (state is PostsLoadingState) {
            return const Center(
              child: CircularProgressIndicator(),
            );
          }
          if (state is ErrorPostState) {
            return Text(state.message);
          }
          if (state is PostsLoadedState) {
            return _buildListView(state);
          }
          return const Text("Nothing found");
        }),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          ref.read(postsProvider.notifier).fetchPosts();
        },
        child: const Icon(Icons.add),
      ),
    );
  }

  Widget _buildListView(PostsLoadedState state) {
    return ListView.builder(
        itemCount: state.posts.length,
        itemBuilder: (ctx, index) {
          Post post = state.posts[index];

          return ListTile(
            leading: CircleAvatar(
              child: Text(post.id.toString()),
            ),
            title: Text(post.title),
          );
        });
  }
}
