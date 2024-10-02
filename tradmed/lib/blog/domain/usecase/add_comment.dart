// lib/domain/use_cases/add_comment.dart
import 'package:tradmed/blog/domain/entities/blog_post.dart';
import 'package:tradmed/blog/domain/repositories/blog_repositeries.dart';


class AddComment {
  final BlogRepository repository;

  AddComment(this.repository);

  Future<void> execute(Comment comment) {
    return repository.addComment(comment);
  }
}
