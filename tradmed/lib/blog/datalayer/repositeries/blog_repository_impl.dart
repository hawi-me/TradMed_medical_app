// lib/data/repositories/blog_repository_impl.dart
import 'package:http/http.dart' as http;
import 'package:tradmed/blog/domain/repositories/blog_repositeries.dart';
import 'dart:convert';
import '../../domain/entities/blog_post.dart';


class BlogRepositoryImpl implements BlogRepository {
  final String apiUrl;

  BlogRepositoryImpl(this.apiUrl);

  @override
  Future<List<BlogPost>> getBlogPosts() async {
    final response = await http.get(Uri.parse(apiUrl));

    if (response.statusCode == 200) {
      List<dynamic> jsonResponse = json.decode(response.body);
      return jsonResponse.map((post) => BlogPostModel.fromJson(post)).toList();
    } else {
      throw Exception('Failed to load blog posts');
    }
  }

  @override
  Future<void> addBlogPost(BlogPost blogPost) async {
    final response = await http.post(
      Uri.parse(apiUrl),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
      },
      body: json.encode(blogPost.toJson()),
    );

    if (response.statusCode != 201) {
      throw Exception('Failed to add blog post');
    }
  }
  
Future<void> addComment(Comment comment) async {
    final response = await http.post(
      Uri.parse('${apiUrl}/${comment.postId}/comments'),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
      },
      body: json.encode({
        'id': comment.id,
        'userId': comment.userId,
        'content': comment.content,
      }),
    );

    if (response.statusCode != 201) {
      throw Exception('Failed to add comment');
    }
  }
  
  @override
  Future<void> editBlogPost(BlogPost blogPost) async {
    final response = await http.put(
      Uri.parse('$apiUrl/${blogPost.id}'),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
      },
      body: json.encode(blogPost.toJson()), // Implement toJson method
    );

    if (response.statusCode != 200) {
      throw Exception('Failed to edit blog post');
    }
  }
  
  @override
  @override
  Future<void> reactToPost(Reaction reaction) async {
    final response = await http.post(
      Uri.parse('${apiUrl}/${reaction.postId}/reactions'),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
      },
      body: json.encode({
        'userId': reaction.userId,
        'type': reaction.type,
      }),
    );

    if (response.statusCode != 201) {
      throw Exception('Failed to add reaction');
    }
  }
}

// lib/data/repositories/blog_repository_impl.dart
