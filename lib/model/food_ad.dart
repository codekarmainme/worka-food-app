class FoodAdItem {
  final String name;
  final String imageUrl;
  final List<String> ingredients;
  final num price; // Add this line

  FoodAdItem({
    required this.name,
    required this.imageUrl,
    required this.ingredients,
    required this.price, // Add this line
  });
}
