import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';
import 'package:get/get.dart';
import 'package:karima/views/widgets/custom_button.dart';
import 'package:karima/views/widgets/custom_text_form_field.dart';
import 'package:karima/views/widgets/widgets.dart';

import '../../core/services/firestore_user.dart';
import '../../core/view_model/profile_view_model.dart';


class ShippingDetailsView extends StatelessWidget {
  
  final full = TextEditingController(text: "Anything");
  final add = TextEditingController();
  final prov = TextEditingController();
  final pcode = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
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
      body: GetBuilder<ProfileViewModel>(
                init: ProfileViewModel(),
                builder: (controller) {
                  return SingleChildScrollView(
                    child: Column(
                      children: [
                        const SizedBox(height: 60,),
                        const CustomText(
                          text: "Shipping Details",
                          alignment: Alignment.center,
                          fontSize: 24,
                        ),
                        const SizedBox(height: 20,),
                        Padding(
                          padding: const EdgeInsets.only(left: 20, right: 20),
                          child: Column(
                            children: [
                              CustomTextFormField(
                                text: "Address",
                                hint: controller.userModel!.address!,
                                color1: Colors.green.shade500,
                                color2: Colors.black,
                                onSave: (value){},
                                validator: (value){},
                                controller: add,
                              ),
                              const SizedBox(height: 30,),
                              CustomTextFormField(
                                text: "Province",
                                hint: controller.userModel!.province!,
                                color1: Colors.green.shade500,
                                color2: Colors.black,
                                onSave: (value){},
                                validator: (value){},
                                controller: prov,
                              ),
                              const SizedBox(height: 30,),
                              CustomTextFormField(
                                text: "Postal Code",
                                hint: controller.userModel!.postalCode!,
                                color1: Colors.green.shade500,
                                color2: Colors.black,
                                onSave: (value){},
                                validator: (value){},
                                controller: pcode,
                              ),
                              const SizedBox(height: 50,),
                              Row(
                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                children: [
                                  CustomButton(
                                    onPress: () {
                                      Get.back();
                                    },
                                    text: "Cancel",
                                  ),
                                  CustomButton(
                                    onPress: () async{
                                      if(add.text != ""){
                                        controller.userModel!.address = add.text;
                                      }
                                      if (prov.text != "") {
                                        controller.userModel!.province = prov.text;
                                      }
                                      if (pcode.text != "") {
                                        controller.userModel!.postalCode = pcode.text;
                                      }
                                      
                                      await FireStoreUser().addUserToFirestore(controller.userModel!);
                                      
                                      Get.back();
                                      Get.snackbar(
                                        'Information Saved!',
                                        'Your new shipping details have been saved successefuly',
                                        colorText: Colors.black,
                                        snackPosition: SnackPosition.TOP,
                                      );
                                    },
                                    text: "Save",
                                  ),
                                ],
                              ),
                            ],
                          ),
                        )
                      ],
                    ),
                  );
                }
              ),
    );
  }

  
}