import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';
import 'package:get/get.dart';
import 'package:karima/core/view_model/profile_view_model.dart';
import 'package:karima/views/auth/login_screen.dart';
import 'package:karima/views/widgets/custom_button.dart';
import 'package:karima/views/widgets/widgets.dart';

class ProfileView extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    return GetBuilder<ProfileViewModel>(
      init: ProfileViewModel(),
      builder: (controller) => Scaffold(
        body: Container(
          padding: EdgeInsets.only(top: 50),
          child: SingleChildScrollView(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Container(
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      Container(
                        height: 120,
                        width: 120,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.all(Radius.circular(100)),
                          image: DecorationImage(
                            image: controller.userModel == null
                            ? AssetImage('assets/images/item.png')
                            : controller.userModel.pic,
                            fit: BoxFit.fill,
                            ),
                        ),
                      ),
                      Column(
                        children: [
                          CustomText(
                            text: controller.userModel.name,
                            fontSize: 32,
                          ),
                          CustomText(
                            text: controller.userModel.email,
                            fontSize: 24,
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
                const SizedBox(height: 100,),
                Container(
                  child: ElevatedButton(
                    onPressed: () {
                      
                    },
                    child: ListTile(
                      title: const CustomButton(
                        text: "Edit Profile",
                      ),
                      leading: Image.asset("assets/images/google.png"),
                      trailing: const Icon(
                        Icons.navigate_next,
                        color: Colors.black,
                        ),
                    ),
                  ),
                ), const SizedBox(height: 20,),
                Container(
                  child: ElevatedButton(
                    onPressed: () {
                      
                    },
                    child: ListTile(
                      title: const CustomButton(
                        text: "Shipping Address",
                      ),
                      leading: Image.asset("assets/images/google.png"),
                      trailing: const Icon(
                        Icons.navigate_next,
                        color: Colors.black,
                        ),
                    ),
                  ),
                ), const SizedBox(height: 20,),
                Container(
                  child: ElevatedButton(
                    onPressed: () {
                      
                    },
                    child: ListTile(
                      title: const CustomButton(
                        text: "Order History",
                      ),
                      leading: Image.asset("assets/images/google.png"),
                      trailing: const Icon(
                        Icons.navigate_next,
                        color: Colors.black,
                        ),
                    ),
                  ),
                ), const SizedBox(height: 20,),
                Container(
                  child: ElevatedButton(
                    onPressed: () {
                      
                    },
                    child: ListTile(
                      title: const CustomButton(
                        text: "Cards",
                      ),
                      leading: Image.asset("assets/images/google.png"),
                      trailing: const Icon(
                        Icons.navigate_next,
                        color: Colors.black,
                        ),
                    ),
                  ),
                ), const SizedBox(height: 20,),
                Container(
                  child: ElevatedButton(
                    onPressed: () {
                      
                    },
                    child: ListTile(
                      title: const CustomButton(
                        text: "Notifications",
                      ),
                      leading: Image.asset("assets/images/google.png"),
                      trailing: const Icon(
                        Icons.navigate_next,
                        color: Colors.black,
                        ),
                    ),
                  ),
                ), const SizedBox(height: 20,),
                Container(
                  child: ElevatedButton(
                    onPressed: () {
                      controller.signOut();
                      Get.offAll(LoginScreen());
                    },
                    child: ListTile(
                      title: const CustomButton(
                        text: "Logout",
                      ),
                      leading: Image.asset("assets/images/google.png"),
                    ),
                  ),
                ), const SizedBox(height: 20,),
              ],
            ),
          ),
        ),
      ),
    );
  }
}