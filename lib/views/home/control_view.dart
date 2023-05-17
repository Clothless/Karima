import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:karima/core/view_model/auth_view_model.dart';
import 'package:karima/core/view_model/control_view_model.dart';
import 'package:karima/views/auth/login_screen.dart';

class ControlView extends GetWidget<AuthViewModel> {

  @override
  Widget build(BuildContext context) {
    return Obx((){
      if (Get.find<AuthViewModel>().user == null) {
        return LoginScreen();
      } else {
        return GetBuilder<ControlViewModel>(
        init: ControlViewModel(),
        builder: (controller) => Scaffold(
            body: controller.currentScreen,
            bottomNavigationBar: BottomNavBar(),
          ),
      );
      }
    });
  }
}

class BottomNavBar extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    return GetBuilder<ControlViewModel>(
      init: ControlViewModel(),
      builder: (controller) => BottomNavigationBar(
        items: const [
          BottomNavigationBarItem(
            label: 'Explore',
            icon: Padding(
              padding: EdgeInsets.only(top: 20.0),
              child: Icon(Icons.home_outlined, color: Colors.black,),
            ),
            ),
          BottomNavigationBarItem(
            label: 'Cart',
            icon: Padding(
              padding: EdgeInsets.only(top: 20.0),
              child: Icon(Icons.shopping_cart_outlined, color: Colors.black,),
            ),
            ),
          BottomNavigationBarItem(
            label: 'Account',
            icon: Padding(
              padding: EdgeInsets.only(top: 20.0),
              child: Icon(Icons.person_outline_outlined, color: Colors.black,),
            ),
            ),
        ],
        currentIndex: controller.navigatorValue,
        onTap: (index) {
          controller.changeSelectedValue(index);
        },
        elevation: 0,
        backgroundColor: Colors.grey.shade200,
      ),
    );
  }
}