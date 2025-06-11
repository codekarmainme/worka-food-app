import 'package:food_app/model/food_ad.dart';
import 'package:food_app/model/food_item.dart';

List<FoodItem> foodItems = [
  FoodItem(
    name: "ጥህሎ",
    imageUrl: "lib/assets/Tihlo.jpg",
    price: 220,
    ingredients: ["Meat", "Onions", "Spices"], 
    catagory: "Traditional"
  ),
  FoodItem(
    name: "ፍትፍት",
    imageUrl: "lib/assets/Fitfit.JPG",
    price: 800,
    ingredients: ["Meat", "Cheese", "Spices"], 
     catagory: "Traditional"
  ),
  FoodItem(
    name: "አንጮቴ",
    imageUrl: "lib/assets/Anchotie1.JPG",
    price: 100,
    ingredients: ["Berbere", "Onions", "Oil"], 
     catagory: "Traditional"// Add ingredients here
  ),
  FoodItem(
    name: "አይብ",
    imageUrl: "lib/assets/Ayb.JPG",
    price: 80,
    ingredients: ["Lentils", "Vegetables", "Spices"], 
     catagory: "Traditional",// Add ingredients here
  ),
  FoodItem(
    name: "በያይነት",
    imageUrl: "lib/assets/Beyaynet.JPG",
    price: 250,
    ingredients: ["Beef", "Cheese", "Bun", "Lettuce"],
     catagory: "Traditional" // Add ingredients here
  ),
  FoodItem(
    name: "ጩሩርሳ",
    imageUrl: "lib/assets/Churursa.JPG",
    price: 10,
    ingredients: ["Flour", "Water", "Yeast"],
     catagory: "Traditional" // Add ingredients here
  ),
  FoodItem(
    name: "ድንች",
    imageUrl: "lib/assets/Dintch.JPG",
    price: 300,
    ingredients: ["Fish", "Lemon", "Spices"],
     catagory: "Traditional" // Add ingredients here
  ),
  FoodItem(
    name: "ጎመን ክትፎ",
    imageUrl: "lib/assets/Gomen Kitfo.JPG",
    price: 180,
    ingredients: ["Dough", "Tomato Sauce", "Cheese"],
     catagory: "Traditional" // Add ingredients here
  ),
  FoodItem(
    name: "Club sandwich",
    imageUrl: "lib/assets/sandwich.jpg",
    price: 120,
    ingredients: ["chicken—bacon", "lettuce", "tomato",],
     catagory: "Fast food" // Add ingredients here
  ),
  FoodItem(
    name: "Fries",
    imageUrl: "lib/assets/fries.png",
    price: 40,
    ingredients: ["Potatoes", "Vegetable Oil"],
     catagory: "Fast food" // Add ingredients here
  ),
  FoodItem(
    name: "Pizza",
    imageUrl: "lib/assets/pizza.png",
    price: 40,
    ingredients: ["flour", "onion", "tomato", "capsicum",],
    catagory: "Fast food" // Add ingredients here
  ),
  FoodItem(
    name: "Dairy queen",
    imageUrl: "lib/assets/dq.png",
    price: 70,
    ingredients: ["milkfat",  "nonfat milk", "sugar", "corn syrup",],
    catagory: "Drink" // Add ingredients here
  ),
    FoodItem(
    name: "Coffee",
    imageUrl: "lib/assets/coffee.png",
    price: 20,
    ingredients: ["Coffee" , "sugar"],
    catagory: "Drink" // Add ingredients here
  ),
  FoodItem(
    name: "Orange juice",
    imageUrl: "lib/assets/Orange.jpg",
    price: 20,
    ingredients: ["Orange" , "sugar"],
    catagory: "Drink" // Add ingredients here
  ),
];

final List<FoodAdItem> foods = [
  FoodAdItem(
    imageUrl: 'lib/assets/Tegabino.JPG',
    name: 'ተጋቢኖ',
    ingredients: ["Shiro", "Tomato Sauce", "Meatballs"],
    
    price: 300,
    

  ),
  FoodAdItem(
    imageUrl: 'lib/assets/recom1.jpg',
    name: 'ገንፎ',
    ingredients: ["Flour", "Water", "Spices"],
    price: 500,
  ),
  FoodAdItem(
    imageUrl: 'lib/assets/recom2.jpg',
    name: 'Fruits',
    ingredients: ["Assorted Fruits"], // Add ingredients here
    price: 200,
  ),
];
