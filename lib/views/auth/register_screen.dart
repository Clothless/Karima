import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';
import 'package:get/get.dart';
import 'package:karima/views/auth/login_screen.dart';

import '../widgets/custom_button.dart';
import '../widgets/custom_text_form_field.dart';
import '../widgets/widgets.dart';

class RegisterScreen extends StatelessWidget {
  final GlobalKey<FormState> _formkey = GlobalKey<FormState>();

  final name = TextEditingController();
  final email = TextEditingController();
  final password = TextEditingController();
  final curr = "";


  
  get controller => null;

  
  
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
                      text:"Sign Up",
                      fontSize: 30,
                      color: Colors.black,
                      ),
                      GestureDetector(
                        onTap: (){
                          Get.to(LoginScreen());
                        },
                        child: const CustomText(
                          text: "Log In",
                          fontSize: 18,
                          color: Colors.blueAccent,
                        ),
                      )
                  ],),
                  const SizedBox(height: 10,),
                  const CustomText(
                    text: "Create account for free!",
                    fontSize: 14,
                    color: Colors.grey,
                  ),
                  const SizedBox(height: 40,),
                
                CustomTextFormField(
                  controller: name,
                  text: "Username",
                  hint: "@Username",
                  color1: Colors.black,
                  color2: Colors.grey,
                  onSave: (value){
                    controller?.name = value;
                  },
                  validator: (value){
                    print(name.text);
                    if(value == null){
                      print("Error");
                    }
                  },
                  ),
                  const SizedBox(height: 40,),
                
                CustomTextFormField(
                  controller: email,
                  text: "Email",
                  hint: "ibradzm@gmail.com",
                  color1: Colors.black,
                  color2: Colors.grey,
                  onSave: (value){
                    controller?.email = value;
                  },
                  validator: (value){
                    if(value == null){
                      print("Error");
                    }
                  },
                  ),
                const SizedBox(height: 40,),
                CustomTextFormField(
                  controller: password,
                  text: "Password",
                  hint: "azerqsdf",
                  color1: Colors.black,
                  color2: Colors.grey,
                  onSave: (value){
                    value = password.text;
                  },
                  validator: (value){
                    print(value);
                    if(value == null){
                      print("Error");
                    }
                  },
                ),
                const SizedBox(height: 20,),
                CustomButton(
                  onPress: () {
                    Future.delayed(Duration.zero,(){
                      _formkey.currentState.save();
                      if(_formkey.currentState.validate()){
                        if(controller.email != "" && controller.password != ""){
                          controller.signUpWithEmailAndPassword(controller.email, controller.password);
                        }
                      }
                    });
                  },
                  text: "Register",
                  foreground: Colors.white,
                  background: Colors.green,
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