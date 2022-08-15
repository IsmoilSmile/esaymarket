import 'package:esaymarket/controllers/cart_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_connect/http/src/response/response.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:get/get_state_manager/src/simple/get_controllers.dart';
import '../data/api/repostory/popular_product_repo.dart';
import '../models/cart_model.dart';
import '../models/product_models.dart';
import '../utils/color.dart';

class PopularProductController extends GetxController {
  final PopularProductRepo popularProductRepo;

  PopularProductController({required this.popularProductRepo});

  List<ProductModel> _popularProductList = [];

  List<ProductModel> get popularProductList => _popularProductList;
  late CartController _cart;

  bool _isLoaded = false;

  bool get isLoaded => _isLoaded;

  int _quantity = 0;

  int get quantity => _quantity;
  int _inCartItems = 0;

  int get inCartItems => _inCartItems + _quantity;

  Future<void> getPopularProductList() async {
    Response response = await popularProductRepo.getPopularProductList();
    if (response.statusCode == 200) {
      _popularProductList = [];
      _popularProductList.addAll(Product.fromJson(response.body).products);
      _isLoaded = true;
      update();
    } else {}
  }

  void setQuaantity(bool isIncrement) {
    if (isIncrement) {
      _quantity = checkQuantity(_quantity + 1);
    }else {
      _quantity = checkQuantity(_quantity - 1);
    }
    update();
  }
  int checkQuantity(int quantity) {
    if ((_inCartItems + quantity) < 0) {
      Get.snackbar(
        "Item count",
        "You can not reduce more!",
        backgroundColor: FoodColor.mainColor,
        colorText: Colors.white,
      );
      if(_inCartItems > 0){
        _quantity = - _inCartItems;
        return _quantity;
      }
      return 0;
    } else if ((_inCartItems + quantity) > 20) {
      Get.snackbar(
        "Item count",
        "You can not add more!",
        backgroundColor: FoodColor.mainColor,
        colorText: Colors.white,
      );
      return 20;
    } else {
      return quantity;
    }
  }

  void initProduct(ProductModel product, CartController cart) {
    _quantity = 0;
    _inCartItems = 0;
    _cart = cart;
    var exist = false;
    exist = _cart.exitInCart(product);
    print("Exist or not " + exist.toString());
    if (exist) {
      _inCartItems = _cart.getQuanitity(product);
      print(" the quanitity cart  " + _inCartItems.toString());
    }
  }

  void addItem(
    ProductModel product,
  ) {
    _cart.addItem(product, _quantity);
    _quantity = 0;
    _inCartItems = _cart.getQuanitity(product);
    _cart.items.forEach(
      (key, value) {
        print("This id is" +
            value.id.toString() +
            "this quanitiy" +
            value.quantity.toString());
      },
    );
    update();
  }

  int get totalItems {
    return _cart.totalItems;
  }

  List<CartModel> get getItems{
    return _cart.getItems;
  }
}