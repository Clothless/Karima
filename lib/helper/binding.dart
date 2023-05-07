import 'package:get/get.dart';
import 'package:karima/core/view_model/auth_view_model.dart';
import 'package:karima/core/view_model/checkout_view_model.dart';
import 'package:karima/helper/local_storage_data.dart';

import '../core/view_model/cart_view_model.dart';
import '../core/view_model/control_view_model.dart';
import '../core/view_model/home_view_model.dart';


class Binding extends Bindings{
  @override
  Future<void> dependencies() async {
    Get.lazyPut(() => ControlViewModel());
    Get.lazyPut(() => AuthViewModel());
    Get.lazyPut(() => HomeViewModel());
    Get.lazyPut(() => CartViewModel());
    Get.lazyPut(() => LocalStorageData());
    Get.lazyPut(() => ControlViewModel());
    Get.lazyPut(() => CheckoutViewModel());
  }

}