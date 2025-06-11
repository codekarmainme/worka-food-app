import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:food_app/model/food_oncart.dart';

class OrderItem {
  String firstName;
  String lastName;
  String address;
  String phoneNumber;
  String email;
  List<FoodOnCartItem> cartItems; // List of items in the cart
  num totalAmount;
  Timestamp orderTime;
  num orderno;
  String uid;
   // For recording the time the order was placed

  OrderItem({
    required this.firstName,
    required this.lastName,
    required this.address,
    required this.phoneNumber,
    required this.email,
    required this.cartItems,
    required this.totalAmount,
    required this.orderTime,
    required this.orderno,
    required this.uid
  });

  // Convert the Order to a Map to send to Firestore
  Map<String, dynamic> toMap() {
    return {
      'firstName': firstName,
      'lastName': lastName,
      'address': address,
      'phoneNumber': phoneNumber,
      'email': email,
      'cartItems': cartItems.map((item) => item.toMap()).toList(), // Convert cart items to Map
      'totalAmount': totalAmount,
      'orderTime': orderTime,
      'orderno':orderno,
      'paid':false,
      'accepted':false,
      'delivering':false,
      'delivered':false,
      "uid":uid
    };
  }
}
//   // Create an Order object from a Firestore document snapshot
//   factory Order.fromDocument(DocumentSnapshot doc) {
//     return Order(
//       firstName: doc['firstName'],
//       lastName: doc['lastName'],
//       address: doc['address'],
//       phoneNumber: doc['phoneNumber'],
//       email: doc['email'],
//       cartItems: (doc['cartItems'] as List)
//           .map((item) => FoodOnCartItem(item))
//           .toList(),
//       totalAmount: doc['totalAmount'],
//       orderTime: doc['orderTime'],
//     );
//   }
// }
