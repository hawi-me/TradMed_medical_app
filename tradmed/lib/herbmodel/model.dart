class Herb {
  final String name;
  final String usage;
  final double price;
  final String currency;
  final List<String> sideEffects;
  final String image;

  Herb({
    required this.name,
    required this.usage,
    required this.price,
    required this.currency,
    required this.sideEffects,
    required this.image,
  });

  // Factory method to create Herb object from JSON
  factory Herb.fromJson(Map<String, dynamic> json) {
    return Herb(
      name: json['name'] ?? 'Unknown',
      usage: json['usage'] ?? 'No usage information',
      price: (json['price'] ?? 0).toDouble(),
      currency: json['currency'] ?? 'Unknown currency',
      sideEffects: List<String>.from(json['side_effects'] ?? []),
      image: json['image'] ?? '',
    );
  }
}
