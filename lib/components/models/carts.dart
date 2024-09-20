class Cart {
  final String imagePath;
  final String name;
  final String price;
  final String content;
  Cart(
      {required this.imagePath,
      required this.name,
      required this.price,
      required this.content});
  factory Cart.fromJson(Map<String, dynamic> json) => Cart(
      imagePath: json['imagePath'],
      name: json['name'],
      price: json['price'],
      content: json['content']);
  Map<String, dynamic> toJson() {
    return {
      'imagePath': imagePath,
      'name': name,
      'price': price,
      'content': content
    };
  }
}
