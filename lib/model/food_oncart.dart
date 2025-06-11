class FoodOnCartItem {
  final String name;
  final String imageUrl;
  final num price;
  num quantity;

  FoodOnCartItem({
    required this.name,
    required this.imageUrl,
    required this.price,
    required this.quantity,
  });
    Map<String, dynamic> toMap() {
    return {
      'name': name,
      'quantity': quantity,
      'price': price,
      'imageUrl':imageUrl
    };
  }

  // Create FoodOnCartItem from Map
  factory FoodOnCartItem.fromMap(Map<String, dynamic> map) {
    return FoodOnCartItem(
      name: map['name'],
      quantity: map['quantity'],
      price: map['price'],
      imageUrl: map['imageUrl']
    );
  }
}

