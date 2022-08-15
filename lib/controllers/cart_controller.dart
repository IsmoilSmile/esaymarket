import 'package:esaymarket/data/api/repostory/cart_repo.dart';
import 'package:esaymarket/models/product_models.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:get/get_state_manager/src/simple/get_controllers.dart';

import '../models/cart_model.dart';
import '../utils/color.dart';

class CartController extends GetxController{
  final CartRepo cartRepo;
  CartController({required this.cartRepo});

  Map<int, CartModel> _items = {};
  Map<int, CartModel> get items => _items;

  void addItem(ProductModel product, int quanitity){

    var totalQuanitity = 0;
    if(_items.containsKey(product.id!)){
      _items.update(product.id!, (value){
        totalQuanitity = value.quantity! + quanitity;
        return CartModel(
          id : value.id,
          name : value.name,
          price : value.price,
          img : value.img,
          quantity : value.quantity! + quanitity,
          isExit : true,
          time : DateTime.now().toString(),
        );
      });
      if(totalQuanitity <= 0){
        _items.remove(product.id);
      }
    }else{
      if(quanitity > 0){
        _items.putIfAbsent(product.id!, () {
          return CartModel(
            id : product.id,
            name : product.name,
            price : product.price,
            img : product.img,
            quantity : quanitity,
            isExit : true,
            time : DateTime.now().toString(),
          );});
      }else{
        Get.snackbar(
                "Item count",
                "You should at least add item!",
                backgroundColor: FoodColor.mainColor,
                colorText: Colors.white,
              );
      }
    }
  }

  bool exitInCart(ProductModel product){
    if(_items.containsKey(product.id)){
      return true;
    }
    return false;
  }

  int getQuanitity(ProductModel product){
    var quanitity = 0;
    if(_items.containsKey(product.id)){
      _items.forEach((key, value) {
        if(key == product.id){
          quanitity = value.quantity!;
        }
      });
    }
    return quanitity;
  }

  int get totalItems{
    var totaQuantity = 0;
    _items.forEach((key, value) {
      totaQuantity += value.quantity!;
    });
    return totaQuantity;
  }

  List<CartModel> get getItems{
   return _items.entries.map((e) {
     return e.value;
    }).toList();
  }
}