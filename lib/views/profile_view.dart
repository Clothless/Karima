import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:karima/core/view_model/profile_view_model.dart';
import 'package:karima/views/auth/login_screen.dart';
import 'package:karima/views/change_password_view.dart';
import 'package:karima/views/edit_profile_view.dart';
import 'package:karima/views/shipping_details_view.dart';
import 'package:karima/views/widgets/custom_button.dart';
import 'package:karima/views/widgets/widgets.dart';

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
            child: Column(
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
                  onPressed: () {
                    Get.to(EditProfilePage());
                  },
                  child: ListTile(
                    title: const CustomButton(
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
                  onPressed: () {
                    Get.to(ShippingDetailsView());
                  },
                  child: ListTile(
                    title: const CustomButton(
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
                  onPressed: () {
                    
                  },
                  child: ListTile(
                    title: const CustomButton(
                      text: "Order History",
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
                  onPressed: () {
                    
                  },
                  child: ListTile(
                    title: const CustomButton(
                      text: "Cards",
                      foreground: Colors.black,
                      background: Colors.white,
                    ),
                    leading: Image.asset("assets/images/credit-card.png"),
                    trailing: const Icon(
                      Icons.navigate_next,
                      color: Colors.black,
                      ),
                  ),
                ), const SizedBox(height: 20,),
                ElevatedButton(
                  onPressed: () {
                    Get.to(ChangePasswordView());
                  },
                  child: ListTile(
                    title: const CustomButton(
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
                  onPressed: () {
                    showDialog(
                      context: context,
                      builder: (BuildContext context) {
                        return AlertDialog(
                          actionsAlignment: MainAxisAlignment.spaceBetween,
                          title: const Text('Change Password?'),
                          content: const Text('In order to change your password, We will ask you to login again, this way we make sure it\'s you!'),
                            actions: [
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
                        );
                      }
                    );
                  },
                  child: ListTile(
                    title: const CustomButton(
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
    );
  }

  

}