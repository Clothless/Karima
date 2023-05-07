import 'dart:io';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:karima/core/view_model/profile_view_model.dart';
import 'package:karima/views/profile_view.dart';
import 'package:karima/views/widgets/custom_button.dart';
import 'package:karima/views/widgets/custom_text_form_field.dart';

class ChangePasswordView extends StatefulWidget {
  @override
  _ChangePasswordViewState createState() => _ChangePasswordViewState();
}

class _ChangePasswordViewState extends State<ChangePasswordView> {
  bool showPassword = false;
  final user = FirebaseAuth.instance.currentUser;
  ImagePicker imagePicker = ImagePicker();
  final oldPass = TextEditingController();
  final newPass = TextEditingController();
  final confirmPass = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return GetBuilder<ProfileViewModel>(
      init: ProfileViewModel(),
      builder: (controller) => Scaffold(
        appBar: AppBar(
          backgroundColor: Theme.of(context).scaffoldBackgroundColor,
          elevation: 1,
          leading: IconButton(
            icon: const Icon(
              Icons.arrow_back,
              color: Colors.green,
            ),
            onPressed: () {
              Get.back();
            },
          ),
        ),
        body: Container(
          padding: const EdgeInsets.only(left: 16, top: 25, right: 16),
          child: GestureDetector(
            onTap: () {
              FocusScope.of(context).unfocus();
            },
            child: ListView(
              children: [
                const Text(
                  "Change Password",
                  style: TextStyle(fontSize: 25, fontWeight: FontWeight.w500),
                ),
                const SizedBox(
                  height: 15,
                ),
                Center(
                  child: Stack(
                    children: [
                      Container(
                        width: 130,
                        height: 130,
                        decoration: BoxDecoration(
                            border: Border.all(
                                width: 4,
                                color: Theme.of(context).scaffoldBackgroundColor),
                            boxShadow: [
                              BoxShadow(
                                  spreadRadius: 2,
                                  blurRadius: 10,
                                  color: Colors.black.withOpacity(0.1),
                                  offset: Offset(0, 10))
                            ],
                            shape: BoxShape.circle,
                            image: const DecorationImage(
                                fit: BoxFit.cover,
                                image: AssetImage("assets/images/padlock.png"),
                                )),
                      ),
                      
                    ],
                  ),
                ),
                const SizedBox(
                  height: 35,
                ),
                
                buildTextField("New Password", "", true, newPass),
                buildTextField("Confirm", "", true, confirmPass),
                const SizedBox(
                  height: 35,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    CustomButton(
                      onPress: () {
                        Get.back();
                      },
                      text: "CANCEL",
                    ),
                    CustomButton(
                      onPress: () async{
                        if(newPass.text == confirmPass.text){
                          try {
                            await user?.updatePassword(newPass.text);

                            Get.back();

                            Get.snackbar(
                              'Information Saved!',
                              'Your new credentials have been saved successefuly',
                              colorText: Colors.black,
                              snackPosition: SnackPosition.TOP,
                            );
                          } catch (e) {
                            Get.snackbar(
                              'Error changing your password',
                              e.toString(),
                              colorText: Colors.black,
                              snackPosition: SnackPosition.TOP,
                            );
                          }
                        }else{
                          Get.snackbar(
                            'Error',
                            'Make sure the new password and its confirmation are the same',
                            colorText: Colors.black,
                            snackPosition: SnackPosition.TOP,
                          );
                        }

                        // Get.snackbar(
                        //   'Information Saved!',
                        //   'Your new credentials have been saved successefuly',
                        //   colorText: Colors.black,
                        //   snackPosition: SnackPosition.TOP,
                        // );
                        // Get.back();
                      },
                      text: "SAVE",
                      ),
                  ],
                )
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget buildTextField(
      String labelText, String placeholder, bool isPasswordTextField, TextEditingController controller) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 35.0),
      child: TextField(
        obscureText: isPasswordTextField ? showPassword : false,
        decoration: InputDecoration(
            suffixIcon: isPasswordTextField
                ? IconButton(
                    onPressed: () {
                      setState(() {
                        showPassword = !showPassword;
                      });
                    },
                    icon: const Icon(
                      Icons.remove_red_eye,
                      color: Colors.grey,
                    ),
                  )
                : null,
            contentPadding: const EdgeInsets.only(bottom: 3),
            labelText: labelText,
            floatingLabelBehavior: FloatingLabelBehavior.always,
            hintText: placeholder,
            hintStyle: const TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.bold,
              color: Colors.black,
            )),
            controller: controller,
      ),
    );
  }
}