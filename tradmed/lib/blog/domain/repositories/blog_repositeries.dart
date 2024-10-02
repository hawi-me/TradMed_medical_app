// lib/domain/repositories/blog_repository.dart
import 'package:tradmed/blog/domain/usecase/get_comment.dart';

import '../entities/blog_post.dart';

abstract class BlogRepository {
  Future<List<BlogPost>> getBlogPosts();
  Future<void> addBlogPost(BlogPost blogPost);
  Future<void> displayBlog(BlogPost blogPost);
  Future<List<Comment>> getComments(String postId); 
  Future<void> addComment(Comment comment);
}
