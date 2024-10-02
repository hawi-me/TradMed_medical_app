import 'package:tradmed/blog/domain/entities/blog_post.dart';
import 'package:tradmed/blog/domain/repositories/blog_repositeries.dart';

class AddBlogPost {
  final BlogRepository repository;

  AddBlogPost(this.repository);

  Future<void> execute(BlogPost blogPost) {
    return repository.addBlogPost(blogPost);
  }
}
