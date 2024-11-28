import 'dart:convert' as convert;

import 'package:http/http.dart' as http;
import 'package:riverpod_api_calling/models/post.dart';

class HttpGetPosts {
  static const String _baseUrl = 'https://jsonplaceholder.typicode.com';
  static const String _endPoint = '/posts';

  Future<List<Post>> getPosts() async {
    List<Post> posts = [];
    try {
      Uri postsUri = Uri.parse('$_baseUrl$_endPoint');
      http.Response response = await http.get(postsUri);
      if (response.statusCode == 200) {
        List<dynamic> postsList = convert.jsonDecode(response.body);
        for (var postsListItem in postsList) {
          Post post = Post.fromMap(postsListItem);
          posts.add(post);
        }
      }
    } catch (e) {
      print(e.toString());
    }
    
    return posts;
  }
}
