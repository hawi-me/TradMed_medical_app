import 'package:tradmed/blog/domain/entities/blog_post.dart';
import 'package:tradmed/blog/domain/repositories/blog_repositeries.dart';

class AddBlogPost {
  final BlogRepository repository;

  AddBlogPost(this.repository);

  Future<void> call(BlogPost blogPost) async {
    await repository.addBlogPost(blogPost);
  }
}