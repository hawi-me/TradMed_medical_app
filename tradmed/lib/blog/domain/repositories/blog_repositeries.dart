// lib/domain/repositories/blog_repository.dart
import '../entities/blog_post.dart';


abstract class BlogRepository {
  Future<List<BlogPost>> getBlogPosts();
  Future<void> addBlogPost(BlogPost blogPost);
  Future<void> editBlogPost(BlogPost blogPost);
  Future<void> addComment(Comment comment);
  Future<void> reactToPost(Reaction reaction);
}
