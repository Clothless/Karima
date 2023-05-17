import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:karima/core/view_model/profile_view_model.dart';
import 'package:karima/views/auth/login_screen.dart';
import 'package:karima/views/profile/shipping_details_view.dart';
import 'package:karima/views/widgets/custom_button.dart';
import 'package:karima/views/widgets/widgets.dart';

import '../admin/manage_categories_view.dart';
import '../admin/manage_products_view.dart';
import '../admin/order_history.dart';
import '../auth/change_password_view.dart';
import 'edit_profile_view.dart';

class ProfileView extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    return GetBuilder<ProfileViewModel>(
      init: ProfileViewModel(),
      builder: (controller) => controller.loading.value
      ? const Center(child: CircularProgressIndicator())
      : Scaffold(
        body: SingleChildScrollView(
          child: Container(
            padding: const EdgeInsets.only(top: 50,),
            child: controller.userModel!.email == "ibradzm@gmail.com"
            ? Column(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Row (
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    Expanded(
                      child: Padding(
                        padding: const EdgeInsets.only(left: 10.0,),
                        child: Container(
                          height: 130,
                          width: 130,
                          decoration: BoxDecoration(
                            border: Border.all(
                              width: 4,
                              color: Colors.white
                            ),
                            shape: BoxShape.circle,
                            image: DecorationImage(
                              image: controller.userModel?.pic == ""
                              ? const AssetImage("assets/images/default-person.png",)
                              : NetworkImage(controller.userModel!.pic!) as ImageProvider,
                              fit: BoxFit.contain,
                              ),
                          ),
                        ),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(right: 10),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          CustomText(
                            text: controller.userModel?.name!,
                            fontSize: 26,
                          ),
                          CustomText(
                            text: controller.userModel?.email!,
                            fontSize: 18,
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 70,),
          

                ElevatedButton(
                  style: ButtonStyle(
                    backgroundColor: MaterialStateProperty.all(Colors.green.shade400),
                  ),
                  onPressed: () {
                    Get.to(EditProfilePage());
                  },
                  child: ListTile(
                    title: CustomButton(
                      onPress: (){
                        Get.to(EditProfilePage());
                      },
                      text: "Edit Profile",
                      foreground: Colors.black,
                      background: Colors.white,
                    ),
                    leading: Image.asset("assets/images/user.png", fit: BoxFit.fill,),
                    trailing: const Icon(
                      Icons.navigate_next,
                      color: Colors.black,
                      ),
                  ),
                ), const SizedBox(height: 20,),


                ElevatedButton(
                  style: ButtonStyle(
                    backgroundColor: MaterialStateProperty.all(Colors.green.shade400),
                  ),
                  onPressed: () {
                    Get.to(ManageProductsView());
                  },
                  child: ListTile(
                    title: CustomButton(
                      onPress: (){
                      },
                      text: "Manage Products",
                      foreground: Colors.black,
                      background: Colors.white,
                    ),
                    leading: Image.asset("assets/images/box.png"),
                    trailing: const Icon(
                      Icons.navigate_next,
                      color: Colors.black,
                      ),
                  ),
                ), const SizedBox(height: 20,),
                ElevatedButton(
                  style: ButtonStyle(
                    backgroundColor: MaterialStateProperty.all(Colors.green.shade400),
                  ),
                  onPressed: () {
                    Get.to(ManageCategorisView());
                  },
                  child: ListTile(
                    title: CustomButton(
                      onPress: (){
                      },
                      text: "Manage Categories",
                      foreground: Colors.black,
                      background: Colors.white,
                    ),
                    leading: Image.asset("assets/images/category.png"),
                    trailing: const Icon(
                      Icons.navigate_next,
                      color: Colors.black,
                      ),
                  ),
                ), const SizedBox(height: 20,),


                ElevatedButton(
                  style: ButtonStyle(
                    backgroundColor: MaterialStateProperty.all(Colors.green.shade400),
                  ),
                  onPressed: () {
                    Get.to(() => OrderHistory());
                  },
                  child: ListTile(
                    title: const CustomButton(
                      text: "Remaining Orders",
                      foreground: Colors.black,
                      background: Colors.white,
                    ),
                    leading: Image.asset("assets/images/order-delivery.png"),
                    trailing: const Icon(
                      Icons.navigate_next,
                      color: Colors.black,
                      ),
                  ),
                ), const SizedBox(height: 20,),


                ElevatedButton(
                  style: ButtonStyle(
                    backgroundColor: MaterialStateProperty.all(Colors.green.shade400),
                  ),
                  onPressed: () {
                    Get.to(ChangePasswordView());
                  },
                  child: ListTile(
                    title: CustomButton(
                      onPress: (){
                        Get.to(ChangePasswordView());
                      },
                      text: "Change Password",
                      foreground: Colors.black,
                      background: Colors.white,
                    ),
                    leading: Image.asset("assets/images/padlock.png"),
                    trailing: const Icon(
                      Icons.navigate_next,
                      color: Colors.black,
                      ),
                  ),
                ), const SizedBox(height: 20,),


                ElevatedButton(
                  style: ButtonStyle(
                    backgroundColor: MaterialStateProperty.all(Colors.green.shade400),
                  ),
                  onPressed: () {
                    showDialog(
                          context: context,
                          builder: (BuildContext context) {
                            return AlertDialog(
                              actionsAlignment: MainAxisAlignment.spaceBetween,
                              title: const Text('Logout!'),
                              content: const Text('Do you really want to logout?'),
                                actions: [
                                  Row(
                                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                                    children: [
                                      CustomButton(       
                                        onPress: () {
                                          Get.back();
                                        },
                                        pad: 0.0,
                                        text: 'Cancel',
                                        fontsize: 12,
                                      ),
                                      CustomButton(       
                                        onPress: () {
                                          controller.signOut();
                                          Get.offAll(LoginScreen());
                                        },
                                        pad: 0.0,
                                        text: 'Continue',
                                        fontsize: 12,
                                      ),
                                    ],
                                  ),
                              ],
                            );
                          }
                        );
                  },
                  child: ListTile(
                    title: CustomButton(
                      onPress: (){
                        showDialog(
                          context: context,
                          builder: (BuildContext context) {
                            return AlertDialog(
                              actionsAlignment: MainAxisAlignment.spaceBetween,
                              title: const Text('Logout!'),
                              content: const Text('Do you really want to logout?'),
                                actions: [
                                  Row(
                                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                                    children: [
                                      CustomButton(       
                                        onPress: () {
                                          Get.back();
                                        },
                                        pad: 0.0,
                                        text: 'Cancel',
                                        fontsize: 12,
                                      ),
                                      CustomButton(       
                                        onPress: () {
                                          controller.signOut();
                                          Get.offAll(LoginScreen());
                                        },
                                        pad: 0.0,
                                        text: 'Continue',
                                        fontsize: 12,
                                      ),
                                    ],
                                  ),
                              ],
                            );
                          }
                        );
                      },
                      text: "Logout",
                      foreground: Colors.black,
                      background: Colors.white,
                    ),
                    leading: Image.asset("assets/images/logout.png"),
                    trailing: const Icon(
                      Icons.logout,
                      color: Colors.black,
                      ),
                  ),
                ), const SizedBox(height: 20,),
              ],
            )
            : Padding(
              padding: const EdgeInsets.only(right: 20, left: 20),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Row (
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      Expanded(
                        child: Padding(
                          padding: const EdgeInsets.only(top: 40),
                          child: Container(
                            height: 130,
                            width: 130,
                            decoration: BoxDecoration(
                              border: Border.all(
                                width: 4,
                                color: Colors.white
                              ),
                              shape: BoxShape.circle,
                              image: DecorationImage(
                                image: controller.userModel?.pic == ""
                                ? const AssetImage("assets/images/default-person.png",)
                                : NetworkImage(controller.userModel!.pic!) as ImageProvider,
                                fit: BoxFit.contain,
                                ),
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 10,),
                  CustomText(
                    text: controller.userModel!.name,
                    fontSize: 28,
                    alignment: Alignment.center,
                  ),
                  const SizedBox(height: 70,),
                      
            
                  Container(
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(15)
                    ),
                    child: ElevatedButton(
                      style: ButtonStyle(
                        backgroundColor: MaterialStateProperty.all(Colors.green),
                      ),
                      onPressed: () {
                        Get.to(EditProfilePage());
                      },
                      child: ListTile(
                        title: CustomButton(
                          onPress: (){
                            Get.to(EditProfilePage());
                          },
                          text: "Edit Profile",
                          foreground: Colors.black,
                          background: Colors.white,
                        ),
                        leading: Image.asset("assets/images/user.png", fit: BoxFit.fill,),
                        trailing: const Icon(
                          Icons.navigate_next,
                          color: Colors.black,
                          ),
                      ),
                    ),
                  ), const SizedBox(height: 20,),
            
            
                  ElevatedButton(
                    style: ButtonStyle(
                      backgroundColor: MaterialStateProperty.all(Colors.green.shade400),
                    ),
                    onPressed: () {
                      Get.to(ShippingDetailsView());
                    },
                    child: ListTile(
                      title: CustomButton(
                        onPress: (){
                          Get.to(ShippingDetailsView());
                        },
                        text: "Shipping Details",
                        foreground: Colors.black,
                        background: Colors.white,
                      ),
                      leading: Image.asset("assets/images/fast.png"),
                      trailing: const Icon(
                        Icons.navigate_next,
                        color: Colors.black,
                        ),
                    ),
                  ), const SizedBox(height: 20,),
            
            
                  ElevatedButton(
                    style: ButtonStyle(
                      backgroundColor: MaterialStateProperty.all(Colors.green.shade400),
                    ),
                    onPressed: () {
                      Get.to(ChangePasswordView());
                    },
                    child: ListTile(
                      title: CustomButton(
                        onPress: (){
                          Get.to(ChangePasswordView());
                        },
                        text: "Change Password",
                        foreground: Colors.black,
                        background: Colors.white,
                      ),
                      leading: Image.asset("assets/images/padlock.png"),
                      trailing: const Icon(
                        Icons.navigate_next,
                        color: Colors.black,
                        ),
                    ),
                  ), const SizedBox(height: 20,),
            
            
                  ElevatedButton(
                    style: ButtonStyle(
                      backgroundColor: MaterialStateProperty.all(Colors.green.shade400),
                    ),
                    onPressed: () {
                      showDialog(
                            context: context,
                            builder: (BuildContext context) {
                              return AlertDialog(
                                actionsAlignment: MainAxisAlignment.spaceBetween,
                                title: const Text('Logout!'),
                                content: const Text('Do you really want to logout?'),
                                  actions: [
                                    Row(
                                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                                      children: [
                                        CustomButton(       
                                          onPress: () {
                                            Get.back();
                                          },
                                          pad: 0.0,
                                          text: 'Cancel',
                                          fontsize: 12,
                                        ),
                                        CustomButton(       
                                          onPress: () {
                                            controller.signOut();
                                            Get.offAll(LoginScreen());
                                          },
                                          pad: 0.0,
                                          text: 'Continue',
                                          fontsize: 12,
                                        ),
                                      ],
                                    ),
                                ],
                              );
                            }
                          );
                    },
                    child: ListTile(
                      title: CustomButton(
                        onPress: (){
                          showDialog(
                            context: context,
                            builder: (BuildContext context) {
                              return AlertDialog(
                                actionsAlignment: MainAxisAlignment.spaceBetween,
                                title: const Text('Logout!'),
                                content: const Text('Do you really want to logout?'),
                                  actions: [
                                    Row(
                                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                                      children: [
                                        CustomButton(       
                                          onPress: () {
                                            Get.back();
                                          },
                                          pad: 0.0,
                                          text: 'Cancel',
                                          fontsize: 12,
                                        ),
                                        CustomButton(       
                                          onPress: () {
                                            controller.signOut();
                                            Get.offAll(LoginScreen());
                                          },
                                          pad: 0.0,
                                          text: 'Continue',
                                          fontsize: 12,
                                        ),
                                      ],
                                    ),
                                ],
                              );
                            }
                          );
                        },
                        text: "Logout",
                        foreground: Colors.black,
                        background: Colors.white,
                      ),
                      leading: Image.asset("assets/images/logout.png"),
                      trailing: const Icon(
                        Icons.logout,
                        color: Colors.black,
                        ),
                    ),
                  ), const SizedBox(height: 20,),
                ],
              ),
            ),

          ),
        ),
      ),
    );
  }

  

}