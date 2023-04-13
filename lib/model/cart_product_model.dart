import 'package:flutter/material.dart';

import '../helper/extension.dart';

class CartProductModel {
  String productID, name, image, price;
  int quantity;

  CartProductModel({
    this.productID,
    this.name,
    this.image,
    this.quantity,
    this.price,
  });

  CartProductModel.fromJson(Map<dynamic, dynamic> map){
    if(map == null){
      return;
    }
    productID = map['productID'];
    name = map['name'];
    image = map['image'];
    quantity = map['quantity'];
    price = map['price'];
  }

  tojson(){
   return {
      'productID': productID,
      'name': name,
      'image': image,
      'quantity': quantity,
      'price': price,
   }; 
  }

}