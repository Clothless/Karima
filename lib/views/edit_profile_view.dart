import 'dart:io';

import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:karima/core/view_model/profile_view_model.dart';
import 'package:karima/views/profile_view.dart';
import 'package:karima/views/widgets/custom_button.dart';

class EditProfilePage extends StatefulWidget {
  @override
  _EditProfilePageState createState() => _EditProfilePageState();
}

class _EditProfilePageState extends State<EditProfilePage> {
  bool showPassword = false;
  ImagePicker imagePicker = ImagePicker();

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
              Get.to(ProfileView());
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
                  "Edit Profile",
                  style: TextStyle(fontSize: 25, fontWeight: FontWeight.w500),
                ),
                const SizedBox(
                  height: 15,
                ),
                Center(
                  child: GestureDetector(
                    onTap: () async{
                          XFile? file = await imagePicker.pickImage(source: ImageSource.gallery);
                          
                          if (file == null) return;

                          Reference referenceRoot = FirebaseStorage.instance.ref();
                          Reference referenceDirImage = referenceRoot.child('images');
                          Reference referenceImageToUpload = referenceDirImage.child(file.name);
                          
                          try {
                            await referenceImageToUpload.putFile(File(file.path));
                            String img = await referenceImageToUpload.getDownloadURL();
                            controller.userModel!.pic = img;
                          } catch (e) {
                            Get.snackbar(
                              'Upload Error',
                              'Can\'t upload your photo',
                              colorText: Colors.black,
                              snackPosition: SnackPosition.TOP,
                            );
                          }
                        },
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
                              image: DecorationImage(
                                  fit: BoxFit.cover,
                                  image: NetworkImage(controller.userModel!.pic!),
                                  )),
                        ),
                        Positioned(
                            bottom: 0,
                            right: 0,
                            child: Container(
                              height: 40,
                              width: 40,
                              decoration: BoxDecoration(
                                shape: BoxShape.circle,
                                border: Border.all(
                                  width: 4,
                                  color: Theme.of(context).scaffoldBackgroundColor,
                                ),
                                color: Colors.green,
                              ),
                              child: const Icon(
                                Icons.edit,
                                color: Colors.white,
                              ),
                            )),
                      ],
                    ),
                  ),
                ),
                const SizedBox(
                  height: 35,
                ),
                buildTextField("Full Name", controller.userModel!.name!, false),
                buildTextField("E-mail", controller.userModel!.email!, false),
                buildTextField("Password", "********", true),
                buildTextField("Location", "TLV, Palestine", false),
                const SizedBox(
                  height: 35,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    CustomButton(
                      onPress: () {
                        Get.to(ProfileView());
                      },
                      text: "CANCEL",
                    ),
                    CustomButton(
                      onPress: () {
                        Get.snackbar(
                          'Information Saved!',
                          'Your new credentials have been saved successefuly',
                          colorText: Colors.black,
                          snackPosition: SnackPosition.TOP,
                        );
                        Get.to(ProfileView());
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
      String labelText, String placeholder, bool isPasswordTextField) {
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
                    icon: Icon(
                      Icons.remove_red_eye,
                      color: Colors.grey,
                    ),
                  )
                : null,
            contentPadding: EdgeInsets.only(bottom: 3),
            labelText: labelText,
            floatingLabelBehavior: FloatingLabelBehavior.always,
            hintText: placeholder,
            hintStyle: TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.bold,
              color: Colors.black,
            )),
      ),
    );
  }
}