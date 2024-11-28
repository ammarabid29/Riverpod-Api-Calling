import 'package:flutter/material.dart';
import 'package:riverpod_api_calling/models/post.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:riverpod_api_calling/services/http_get_posts.dart';

final postsProvider = StateNotifierProvider<PostsNotifier, PostState>(
  (ref) => PostsNotifier(),
);

@immutable
abstract class PostState {}

class InitialPostState extends PostState {}

class PostsLoadingState extends PostState {}

class PostsLoadedState extends PostState {
  PostsLoadedState({required this.posts});

  final List<Post> posts;
}

class ErrorPostState extends PostState {
  ErrorPostState({required this.message});

  final String message;
}

class PostsNotifier extends StateNotifier<PostState> {
  PostsNotifier() : super(InitialPostState());
  final HttpGetPosts _httpGetPosts = HttpGetPosts();

  void fetchPosts() async {
    try {
      state = PostsLoadingState();
      List<Post> posts = await _httpGetPosts.getPosts();
      state = PostsLoadedState(posts: posts);
    } catch (e) {
      state = ErrorPostState(message: e.toString());
    }
  }
}
