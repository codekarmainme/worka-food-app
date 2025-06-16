import 'dart:async';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:food_app/constants/common.dart';
import 'package:food_app/constants/strings.dart';
import 'package:food_app/fake_data.dart';
import 'package:food_app/model/food_item.dart';
import 'package:food_app/screens/cart_screen.dart';
import 'package:food_app/screens/login_screen.dart';
import 'package:food_app/screens/profile_screen.dart';
import 'package:food_app/screens/your_orders_screen.dart';
import 'package:food_app/widgets/catagory_buttons.dart';
import 'package:food_app/widgets/food_dialogue_widget.dart';
import 'package:food_app/widgets/food_item_widget.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import 'package:food_app/provider/cart_provider.dart';
import 'package:food_app/model/food_oncart.dart';
import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:food_app/constants/app_colors.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class OrderScreen extends StatefulWidget {
  OrderScreen({super.key});

  @override
  State<OrderScreen> createState() => _OrderScreenState();
}

class _OrderScreenState extends State<OrderScreen> {
  StreamSubscription? connection;
  List<FoodItem> filteredFoodItems = foodItems; // To store filtered food items
  final TextEditingController _searchController = TextEditingController();
  String activeCatagory = 'All';
  @override
  void initState() {
    super.initState();
    _searchController
        .addListener(_filterFoodItems); // Add listener to the search controller
  }

  // This method checks the current connectivity status
  Future<void> checkConnectivityAndProceed() async {
    var connectivityResult = await Connectivity().checkConnectivity();
    if (connectivityResult == ConnectivityResult.none) {
      showErrorToast(ChapaStrings.connectionError);
    } else {
      Navigator.push(
          context, MaterialPageRoute(builder: (context) => ProfileScreen()));
    }
  }

  // Filter food items based on the search query
  void _filterFoodItems() {
    String query = _searchController.text.toLowerCase();
    setState(() {
      filteredFoodItems = foodItems.where((food) {
        return food.name.toLowerCase().contains(query);
      }).toList();
    });
  }

  void setCatagory(String catagory) {
    setState(() {
      activeCatagory = catagory;
    });
    setState(() {
      if (catagory == "All") {
        filteredFoodItems = foodItems;
      } else {
        filteredFoodItems =
            foodItems.where((food) => food.catagory == catagory).toList();
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Column(
          children: [
            // Search bar and cart: fixed at the top
            Padding(
  padding: const EdgeInsets.symmetric(horizontal: 12.0, vertical: 10.0),
  child: Row(
    mainAxisAlignment: MainAxisAlignment.spaceBetween,
    children: [
      // Modern Search Bar
      Expanded(
        child: Container(
          height: 48,
          decoration: BoxDecoration(
            color: Colors.white.withOpacity(0.8),
            borderRadius: BorderRadius.circular(30),
            boxShadow: [
              BoxShadow(
                color: Colors.deepPurple.withOpacity(0.08),
                blurRadius: 12,
                offset: Offset(0, 4),
              ),
            ],
          ),
          child: TextField(
            controller: _searchController,
            style: GoogleFonts.urbanist(fontWeight: FontWeight.w600),
            decoration: InputDecoration(
              hintText: "Search for food",
              prefixIcon: Icon(FontAwesomeIcons.search, color: primaryColor, size: 20),
              border: InputBorder.none,
              hintStyle: GoogleFonts.urbanist(
                fontSize: 16,
                color: Colors.deepPurple[200],
                fontWeight: FontWeight.w500,
              ),
              contentPadding: EdgeInsets.symmetric(vertical: 12),
            ),
          ),
        ),
      ),
      SizedBox(width: 14),
      // Profile Button with Glass Effect
      GestureDetector(
        onTap: () async {
          User? user = FirebaseAuth.instance.currentUser;
          if (user != null) {
            await checkConnectivityAndProceed();
          } else {
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => LoginPage()),
            );
          }
        },
        child: Container(
          width: 48,
          height: 48,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(16),
            color: Colors.white.withOpacity(0.25),
            boxShadow: [
              BoxShadow(
                color: Colors.deepPurple.withOpacity(0.10),
                blurRadius: 8,
                offset: Offset(0, 2),
              ),
            ],
            border: Border.all(color: Colors.deepPurple.withOpacity(0.12)),
            // Glassmorphism
            backgroundBlendMode: BlendMode.overlay,
          ),
          child: Center(
            child: FaIcon(
              Icons.person_3_outlined,
              size: 28,
              color: primaryColor,
            ),
          ),
        ),
      ),
      SizedBox(width: 10),
      // Cart Button with Badge
      GestureDetector(
        onTap: () {
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => CartScreen()),
          );
        },
        child: Stack(
          clipBehavior: Clip.none,
          children: [
            Container(
              width: 48,
              height: 48,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(16),
                color: Colors.white.withOpacity(0.25),
                boxShadow: [
                  BoxShadow(
                    color: Colors.deepPurple.withOpacity(0.10),
                    blurRadius: 8,
                    offset: Offset(0, 2),
                  ),
                ],
                border: Border.all(color: Colors.deepPurple.withOpacity(0.12)),
              ),
              child: Center(
                child: FaIcon(
                  FontAwesomeIcons.cartShopping,
                  size: 24,
                  color: primaryColor,
                ),
              ),
            ),
            // Cart Badge
            Positioned(
              top: -4,
              right: -4,
              child: Consumer<CartProvider>(
                builder: (context, cartProvider, child) {
                  final count = cartProvider.totalQuantity();
                  return count > 0
                      ? Container(
                          padding: EdgeInsets.all(4),
                          decoration: BoxDecoration(
                            color: Colors.deepPurple,
                            shape: BoxShape.circle,
                            border: Border.all(color: Colors.white, width: 2),
                          ),
                          child: Text(
                            count.toString(),
                            style: GoogleFonts.urbanist(
                              color: Colors.white,
                              fontWeight: FontWeight.bold,
                              fontSize: 13,
                            ),
                          ),
                        )
                      : SizedBox.shrink();
                },
              ),
            ),
          ],
        ),
      ),
    ],
  ),
),
            // Scrollable content starts here
            Expanded(
              child: SingleChildScrollView(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Padding(
                      padding: const EdgeInsets.only(left: 8),
                      child: Text("Popular Foods",
                          style: GoogleFonts.urbanist(
                              fontWeight: FontWeight.bold,
                              fontSize: 24,
                              color: Colors.black)),
                    ),
                    SizedBox(
                      height: 200,
                      child: PageView.builder(
                        scrollDirection: Axis.horizontal,
                        itemCount: foods.length,
                        itemBuilder: (BuildContext context, int index) {
                          var foodAd = foods[index];
                          return Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: GestureDetector(
                              onTap: () {
                                showDialog(
                                  context: context,
                                  builder: (context) => FoodDialogWidget(
                                    imageUrl: foodAd.imageUrl,
                                    name: foodAd.name,
                                    price: foodAd.price,
                                    ingredients: foodAd.ingredients,
                                  ),
                                );
                              },
                              child: Stack(
                                children: [
                                  // Food Image and Details
                                  Container(
                                    height: 150,
                                    width: MediaQuery.of(context).size.width,
                                    decoration: BoxDecoration(
                                      image: DecorationImage(
                                        image: AssetImage(foodAd.imageUrl),
                                        fit: BoxFit.cover,
                                      ),
                                      borderRadius: BorderRadius.circular(10),
                                    ),
                                  ),
                                  // Food Name Overlay
                                  Container(
                                    height: 150,
                                    width: MediaQuery.of(context).size.width,
                                    alignment: Alignment.bottomLeft,
                                    child: Padding(
                                      padding: const EdgeInsets.all(5.0),
                                      child: Stack(
                                        children: [
                                          ShaderMask(
                                            shaderCallback: (bounds) {
                                              return LinearGradient(
                                                colors: [
                                                  Colors.white.withOpacity(1),
                                                  Colors.white.withOpacity(1)
                                                ],
                                                stops: [0.0, 1.0],
                                                begin: Alignment.topLeft,
                                                end: Alignment.bottomRight,
                                              ).createShader(bounds);
                                            },
                                            blendMode: BlendMode.srcATop,
                                            child: Text(
                                              foodAd.name,
                                              style: GoogleFonts.urbanist(
                                                fontSize: 26,
                                                fontWeight: FontWeight.bold,
                                                color: Colors.white,
                                              ),
                                            ),
                                          ),
                                          Text(
                                            foodAd.name,
                                            style: GoogleFonts.urbanist(
                                              fontSize: 26,
                                              fontWeight: FontWeight.bold,
                                              color: Colors.black,
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                  ),
                                  // Add to Cart Button Overlay
                                  Positioned(
                                    bottom: 10,
                                    right: 10,
                                    child: ElevatedButton(
                                      onPressed: () {
                                        // Add the selected food to the cart using CartProvider
                                        Provider.of<CartProvider>(context,
                                                listen: false)
                                            .addTocart(FoodOnCartItem(
                                                name: foodAd.name,
                                                imageUrl: foodAd.imageUrl,
                                                price: foodAd.price,
                                                quantity: 1));
                                      },
                                      style: ElevatedButton.styleFrom(
                                        backgroundColor: primaryColor,
                                        shape: RoundedRectangleBorder(
                                          borderRadius:
                                              BorderRadius.circular(8),
                                        ),
                                      ),
                                      child: Text(
                                        "Add to Cart",
                                        style: GoogleFonts.urbanist(
                                            color: Colors.white),
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          );
                        },
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Container(
                        height: 40,
                        child: ListView(
                          scrollDirection: Axis.horizontal,
                          children: [
                            CatagoryButtons(
                              btnColor: activeCatagory == 'All'
                                  ? Colors.green
                                  : Colors.white,
                              title: "All",
                              setCatagory: () => setCatagory('All'),
                            ),
                            SizedBox(
                              width: 10,
                            ),
                            CatagoryButtons(
                              btnColor: activeCatagory == 'Fast food'
                                  ? Colors.green
                                  : Colors.white,
                              title: "Fast food",
                              setCatagory: () => setCatagory('Fast food'),
                            ),
                            SizedBox(
                              width: 10,
                            ),
                            CatagoryButtons(
                                btnColor: activeCatagory == 'Traditional'
                                    ? Colors.green
                                    : Colors.white,
                                title: "Traditional",
                                setCatagory: () => setCatagory('Traditional')),
                            SizedBox(
                              width: 10,
                            ),
                            CatagoryButtons(
                                btnColor: activeCatagory == 'Drink'
                                    ? Colors.green
                                    : Colors.white,
                                title: "Drink",
                                setCatagory: () => setCatagory('Drink')),
                          ],
                        ),
                      ),
                    ),
                    SizedBox(
                      child: GridView.builder(
                        physics: NeverScrollableScrollPhysics(),
                        shrinkWrap: true,
                        gridDelegate:
                            const SliverGridDelegateWithFixedCrossAxisCount(
                          crossAxisCount: 2,
                          crossAxisSpacing: 10.0,
                          mainAxisSpacing: 10.0,
                          childAspectRatio: 0.7,
                        ),
                        padding: const EdgeInsets.all(10.0),
                        itemCount:
                            filteredFoodItems.length, // Use filtered items
                        itemBuilder: (BuildContext context, int index) {
                          var food = filteredFoodItems[index];
                          return FoodItemWidget(
                            imageUrl: food.imageUrl,
                            name: food.name,
                            price: food.price,
                            ingredients: food.ingredients,
                          );
                        },
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  void _showOptionsDialog(BuildContext context) {
    User? user = FirebaseAuth.instance.currentUser;
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          shape:
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
          contentPadding: EdgeInsets.symmetric(vertical: 20.0),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Divider(),
              ListTile(
                leading: Icon(Icons.shopping_bag, color: Colors.green),
                title: Text('Your Orders', style: GoogleFonts.urbanist()),
                onTap: () {
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => YourOrdersScreen()));
                },
              ),
              Divider(),
              ListTile(
                leading: Icon(Icons.logout, color: primaryColor),
                title: Text('Log out', style: GoogleFonts.urbanist()),
                onTap: () async {
                  await FirebaseAuth.instance.signOut();
                  Navigator.pop(context);
                },
              ),
              Divider(),
            ],
          ),
        );
      },
    );
  }
}
