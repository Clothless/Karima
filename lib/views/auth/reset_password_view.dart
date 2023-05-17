import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';
import 'package:get/get.dart';
import 'package:karima/views/widgets/custom_button.dart';
import 'package:karima/views/widgets/custom_text_form_field.dart';
import 'package:karima/views/widgets/widgets.dart';

class ResetPasswordView extends StatelessWidget {
  TextEditingController emailController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.only(right: 20, left: 20),
        child: Column(
          children: [
            const SizedBox(height: 200,),
            const CustomText(
              text: "Reset Password",
              alignment: Alignment.center,
              fontSize: 26,
            ),
            const SizedBox(height: 30,),
            CustomTextFormField(
              hint: "Enter Your Email",
              color2: Colors.grey,
              onSave: (value){},
              validator: (value){},
              controller: emailController,
            ),
            const SizedBox(height: 20,),
            CustomButton(
              text: "Send",
              background: Colors.green,
              onPress: () async{
                try {
                  await FirebaseAuth.instance.sendPasswordResetEmail(email: emailController.text);
                } catch (e) {
                  Get.snackbar(
                    e.runtimeType.toString(),
                    e.toString(),
                    colorText: Colors.black,
                    snackPosition: SnackPosition.TOP,
                  );
                }
              },
            ),
          ]
        ),
      ),
    );
  }
}