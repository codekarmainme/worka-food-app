import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:food_app/model/food_oncart.dart';
class CartProvider extends ChangeNotifier{
  List<FoodOnCartItem> _food_oncart=[];
  List<FoodOnCartItem> get food_oncart=>_food_oncart;

  void addTocart(FoodOnCartItem foodToCart) {
  bool itemExists = false;

  for (var item in _food_oncart) {
    if (item.name == foodToCart.name) {  
      item.quantity += foodToCart.quantity;
      itemExists = true;
      break;
    }
  }

  if (!itemExists) {
    _food_oncart.add(foodToCart);
  }

  notifyListeners();
}
  num totalQuantity(){
    num totalQuantity=0;
    _food_oncart.forEach((food)=>(
      totalQuantity +=food.quantity
    ));
 
    return totalQuantity;

  }
  num totalbill(){
    num totalBill=0;
    _food_oncart.forEach((food)=>(
      totalBill =totalBill+(food.quantity*food.price)
    ));
    
    return totalBill;
    
  }

void decreaseQuantity(String name){
  for(var item in _food_oncart){
    if(item.name==name){
      if(item.quantity>0){
        item.quantity--;
      }
      else{
         _food_oncart.remove(item);
      }
      break;
    }
  }
  notifyListeners();
}
void increaseQuantity(String name){
  for(var item in _food_oncart){
    if(item.name==name){
       item.quantity++;
    
      break;
    }
  }
  notifyListeners();
}
void removeItem(String name){
  for(var item in _food_oncart){
    if(item.name==name){
      _food_oncart.remove(item);
      break;
    }
  }
  notifyListeners();
}
 Future<void> deleteOrder(num orderno) async {
    try {
      await FirebaseFirestore.instance
          .collection('orders')
          .where('orderno', isEqualTo: orderno)
          .get()
          .then((querySnapshot) {
        for (var doc in querySnapshot.docs) {
          doc.reference.delete();
        }
      });
      notifyListeners();
    } catch (e) {
      print('Error deleting order: $e');
    }
  }
}