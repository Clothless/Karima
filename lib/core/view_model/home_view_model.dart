import 'package:flutter/foundation.dart';
import 'package:get/get.dart';
import 'package:karima/core/services/home_service.dart';
import'package:karima/model/category_model.Dart';

import '../../model/product_model.dart';

class HomeViewModel extends GetxController{
  
  ValueNotifier<bool> get loading => _loading;
  final ValueNotifier<bool> _loading = ValueNotifier(false);

  List<CategoryModel> get categoryModel => _categoryModel;
  final List<CategoryModel> _categoryModel = [];
  List<ProductModel> get productModel => _productModel;
  final List<ProductModel> _productModel = [];

  HomeViewModel(){
    getCategory();
    getBestSelling();
  }

  getCategory() async{
    _loading.value = true;
    HomeService().getCategory().then((value) {
      for(int i = 0; i < value.length; i++){
        _categoryModel.add(CategoryModel.fromJson(value[i].data() as Map<dynamic, dynamic>));
      _loading.value = false;
      }
      update();
    });
  }

  getBestSelling() async{
    _loading.value = true;
    HomeService().getBestSelling().then((value) {
      for(int i = 0; i < value.length; i++){
        _productModel.add(ProductModel.fromJson(value[i].data() as Map<dynamic, dynamic>));
      _loading.value = false;
      }
      update();
    });
  }

}