// lib/domain/entities/comment.dart
class Comment {
  final String id;
  final String postId;
  final String userId;
  final String content;

  Comment({
    required this.id,
    required this.postId,
    required this.userId,
    required this.content,
  });
}

// lib/domain/entities/reaction.dart
class Reaction {
  final String postId;
  final String userId;
  final String type; // e.g., "like", "love", etc.

  Reaction({
    required this.postId,
    required this.userId,
    required this.type,
  });
}

// lib/domain/entities/blog_post.dart (Updated)
class BlogPost {
  final String id;
  final String title;
  final String content;
  final String imageUrl;
  final List<Comment> comments;
  final List<Reaction> reactions;

  BlogPost({
    required this.id,
    required this.title,
    required this.content,
    required this.imageUrl,
    this.comments = const [],
    this.reactions = const [],
  });

  Object? toJson() {}
}
// lib/data/models/blog_post_model.dart

class BlogPostModel extends BlogPost {
  BlogPostModel({
    required String id,
    required String title,
    required String content,
    required String imageUrl,
  }) : super(id: id, title: title, content: content, imageUrl: imageUrl);

  factory BlogPostModel.fromJson(Map<String, dynamic> json) {
    return BlogPostModel(
      id: json['id'],
      title: json['title'],
      content: json['content'],
      imageUrl: json['imageUrl'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'title': title,
      'content': content,
      'imageUrl': imageUrl,
    };
  }
}

