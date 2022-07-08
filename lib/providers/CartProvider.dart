import 'package:flutter/material.dart';
import 'package:shoe_app/model/shoe_model.dart';

class CartProvider with ChangeNotifier {
  List<ShoesModel> cartList = <ShoesModel>[];

  void setCartItems(model) async {
    if (cartList.contains(model)) {
      model.qty = model.qty + 1;
      model.price.total = model.price.total + double.parse(model.price.amount);
    } else {
      cartList.add(model);
    }

    notifyListeners();
  }

  void reduceCartItems(model) async {
    if (cartList.contains(model)) {
      if (model.qty != 0) {
        model.qty = model.qty - 1;
      }
    } else {
      cartList.add(model);
    }

    notifyListeners();
  }

  void removeCartItem(index) async {

    cartList.removeAt(index);

    notifyListeners();
  }

  void removeAllCartItem() async {
    cartList.clear();
    notifyListeners();
  }
}
