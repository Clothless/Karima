import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:karima/core/services/database/cart_database_helper.dart';
import 'package:karima/model/cart_product_model.dart';

class CartViewModel extends GetxController{

  ValueNotifier<bool> get loading => _loading;
  ValueNotifier<bool> _loading = ValueNotifier(false);


  List<CartProductModel> _cartProductModel = [];
  List<CartProductModel> get cartProductModel => _cartProductModel;

  double get totalPrice => _totalPrice;
  double _totalPrice = 0.0;
  var dbHelper = CartDatabaseHelper.db;


  CartViewModel(){
    getAllProduct();
  }

  getAllProduct() async{
    _loading.value = true;
    _cartProductModel = await dbHelper.getAllProduct();
  
    getTotalPrice();
    _loading.value = false;
    update();
  }

  getTotalPrice(){
    for(int i=0; i < _cartProductModel.length; i++){
      _totalPrice += (double.parse(_cartProductModel[i].price) * _cartProductModel[i].quantity);
    }
    update();
  }
  
  addProduct(CartProductModel cartProductModel) async{
    if(_cartProductModel.length == 0){
      await dbHelper.insert(cartProductModel);
      _cartProductModel.add(cartProductModel);
      _totalPrice += (double.parse(cartProductModel.price) * cartProductModel.quantity);
    }
      for(int i=0; i<_cartProductModel.length; i++){
        if(_cartProductModel[i].productID == cartProductModel.productID){
          incresaeQuantity(i);
        }
      }
      await dbHelper.insert(cartProductModel);
      _cartProductModel.add(cartProductModel);
      _totalPrice += (double.parse(cartProductModel.price) * cartProductModel.quantity);
    
    update();
  }

  incresaeQuantity(int index) async{
    _cartProductModel[index].quantity++;
     _totalPrice += (double.parse(_cartProductModel[index].price));
     await dbHelper.updateProduct(_cartProductModel[index]);
     update();
  }
  decreaseQuantity(int index) async{
    _cartProductModel[index].quantity--;
     _totalPrice -= (double.parse(_cartProductModel[index].price));
     await dbHelper.updateProduct(_cartProductModel[index]);
     update();
  }
  


}