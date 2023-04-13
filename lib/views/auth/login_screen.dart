import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:karima/core/view_model/auth_view_model.dart';
import 'package:karima/views/auth/register_screen.dart';
import 'package:karima/views/widgets/custom_button_social_media.dart';

import '../widgets/custom_button.dart';
import '../widgets/custom_text_form_field.dart';
import '../widgets/widgets.dart';

class LoginScreen extends GetWidget<AuthViewModel> {
final GlobalKey<FormState> _formkey = GlobalKey<FormState>();

  final TextEditingController _email = TextEditingController(),_password = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0.0,
        backgroundColor: Colors.white,

      ),
        body: Padding(
          padding: const EdgeInsets.only(
          top: 50,
          right: 30,
          left: 30,
          ),
          child: Form(
            key: _formkey,
            child: SingleChildScrollView(
              child: Column(
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                    const CustomText(
                      text:"Welcome Back,",
                      fontSize: 30,
                      color: Colors.black,
                      ),
                      GestureDetector(
                        onTap: (){
                          Get.to(RegisterScreen());
                        },
                        child: const CustomText(
                          text: "Sign Up",
                          fontSize: 18,
                          color: Colors.blueAccent,
                          
                        ),
                      )
                  ],),
                  const SizedBox(height: 10,),
                  const CustomText(
                    text: "Sign in to continue",
                    fontSize: 14,
                    color: Colors.grey,
                  ),
                  const SizedBox(height: 40,),
                
                CustomTextFormField(
                  controller: _email,
                  text: "Email",
                  hint: "ibradzm@gmail.com",
                  color1: Colors.black,
                  color2: Colors.grey,
                  onSave: (value){
                    controller.email = value;
                  },
                  validator: (value){
                    print(value);
                    if(value == null){
                      print("Error");
                    }
                  },
                  ),
                const SizedBox(height: 40,),
                CustomTextFormField(
                  controller: _password,
                  text: "Password",
                  hint: "azerqsdf",
                  color1: Colors.black,
                  color2: Colors.grey,
                  onSave: (value){
                    controller.password = value;
                  },
                  validator: (value){
                    if(value == null){
                      print("Error");
                    }
                  },
                ),
                const SizedBox(height: 10,),
                const CustomText(
                  text: "Forget Password?",
                  color: Colors.black,
                  alignment: Alignment.topRight,
                ),
                const SizedBox(height: 20,),
                CustomButton(
                  onPress: () {
                    Future.delayed(Duration.zero,(){
                      _formkey.currentState.save();
                      if(_formkey.currentState.validate()){
                        controller.signInWithEmailAndPassword(_email.text, _password.text);
                      }
                    });
                  },
                  text: "Sign In",
                  foreground: Colors.white,
                  background: Colors.green,
                  fontsize: 18,
                ),
                const SizedBox(height:20),
                const CustomText(
                  text: "-OR-",
                  alignment: Alignment.center,
                  fontSize: 18,
                  color: Colors.black,
                ),
                const SizedBox(height: 10,),
                CustomSocialMediaButton(
                  onPressed: () {
                      controller.facebookSignInMethod();
                    },
                  text: "Sign In with Facebook",
                  asset: "assets/images/facebook.png",
                  background: Colors.white,
                  foureground: Colors.black,
                  fontsize: 18,
                ),
                const SizedBox(height: 20,),
                CustomSocialMediaButton(
                  onPressed: (){
                    controller.googleSignInMethod();
                  },
                  text: "Sign In with Google",
                  asset: "assets/images/google.png",
                  background: Colors.white,
                  foureground: Colors.black,
                  fontsize: 18,
                ),
                ],
              ),
            ),
          ),
        ),
      );
  }
}