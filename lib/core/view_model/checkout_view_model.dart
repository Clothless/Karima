import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:karima/views/control_view.dart';

import '../../const.dart';
import '../../helper/enum.dart';

class CheckoutViewModel extends GetxController{
  int? get processIndex => _processIndex;
  int? _processIndex = 0;

  Pages get pages => _pages;
  Pages _pages = Pages.DeliveryTime;

  void changeIndex(int i){
    _processIndex = i;
    if(_processIndex == 1){
      _pages = Pages.AddAddress;
    }else if(_processIndex == 2){
      _pages = Pages.Summary;
    }else if(_processIndex == 3){
      Get.to(ControlView());
    }
    update();
  }

  Color getColor(int i) {
    if (i == _processIndex) {
      return inProgressColor;
    } else if (i < _processIndex!) {
      return Colors.green;
    } else {
      return todoColor;
    }
  }
}