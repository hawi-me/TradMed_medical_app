// lib/domain/use_cases/add_comment.dart
import 'package:tradmed/blog/domain/entities/blog_post.dart';
import 'package:tradmed/blog/domain/repositories/blog_repositeries.dart';


class AddComment {
  final BlogRepository repository;

  AddComment(this.repository);

  Future<void> call(Comment comment) async {
    await repository.addComment(comment);
  }
}

