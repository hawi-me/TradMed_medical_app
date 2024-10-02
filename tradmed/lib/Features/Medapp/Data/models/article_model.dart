class Article {
  final String title;
  final String description1;
  final String description2;
  final String description3;
  final String imageUrl;

  Article({
    required this.title,
    required this.description1,
    required this.description2,
    required this.description3,
    required this.imageUrl,
  });

  factory Article.fromJson(Map<String, dynamic> json) {
    return Article(
      title: json['title'],
      description1: json['description1'],
      description2: json['description2'],
      description3: json['description3'],
      imageUrl: json['imageUrl'],
    );
  }
}

class Articles {
  final List<Article> articles;

  Articles({required this.articles});

  factory Articles.fromJson(List<dynamic> json) {
    List<Article> articles = json.map((i) => Article.fromJson(i)).toList();
    return Articles(articles: articles);
  }
}
