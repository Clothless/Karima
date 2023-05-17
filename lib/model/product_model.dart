import 'package:flutter/material.dart';

import '../helper/extension.dart';

class ProductModel {
  String? productID, name, image, description, size, price, category, brand, weight;

  ProductModel({
    this.productID,
    this.name,
    this.image,
    this.description,
    this.size,
    this.price,
    this.category,
    this.brand,
    this.weight,
  });

  ProductModel.fromJson(Map<dynamic, dynamic> map){
    if(map == null){
      return;
    }
    name = map['name'];
    image = map['image'];
    description = map['description'];
    size = map['size'];
    price = map['price'];
    productID = map['productID'];
    category = map['category'];
    brand = map['brand'];
    weight = map['weight'];
  }

  tojson(){
   return {
      'name': name,
      'image': image,
      'description': description,
      'size': size,
      'price': price,
      'productID': productID,
      'category': category,
      'brand': brand,
      'weight': weight,
   }; 
  }

}