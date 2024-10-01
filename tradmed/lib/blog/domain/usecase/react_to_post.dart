import 'package:tradmed/blog/domain/entities/blog_post.dart';
import 'package:tradmed/blog/domain/repositories/blog_repositeries.dart';

class ReactToPost {
  final BlogRepository repository;

  ReactToPost(this.repository);

  Future<void> call(Reaction reaction) async {
    await repository.reactToPost(reaction);
  }
}
