class Comment {
  final String author;
  final String content;

  Comment({
    required this.author,
    required this.content,
  });

  factory Comment.fromJson(Map<String, dynamic> json) {
    return Comment(
      author: json['author'],
      content: json['content'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'author': author,
      'content': content,
    };
  }
}

class BlogPost {
  final String id;
  final String title;
  final String content;
  final int likes;
  final List<Comment> comments;

  BlogPost({
    required this.id,
    required this.title,
    required this.content,
    required this.likes,
    this.comments = const [],
  });

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'title': title,
      'content': content,
      'likes': likes,
      'comments': comments.map((c) => c.toJson()).toList(),
    };
  }
}

class BlogPostModel extends BlogPost {
  BlogPostModel({
    required String id,
    required String title,
    required String content,
    required int likes,
    List<Comment> comments = const [],
  }) : super(id: id, title: title, content: content, likes: likes, comments: comments);

  factory BlogPostModel.fromJson(Map<String, dynamic> json) {
    return BlogPostModel(
      id: json['id'],
      title: json['title'],
      content: json['content'],
      likes: json['likes'],
      comments: (json['comments'] as List).map((commentJson) => Comment.fromJson(commentJson)).toList(),
    );
  }

  @override
  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'title': title,
      'content': content,
      'likes': likes,
      'comments': comments.map((c) => c.toJson()).toList(),
    };
  }
}
