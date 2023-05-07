import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';
import 'package:get/get.dart';
import 'package:karima/views/auth/login_screen.dart';
import 'package:karima/views/control_view.dart';
import 'package:karima/views/home_view.dart';
import '../../core/view_model/auth_view_model.dart';
import '../widgets/custom_button.dart';
import '../widgets/custom_text_form_field.dart';
import '../widgets/widgets.dart';

class RegisterScreen extends StatelessWidget {
  final GlobalKey<FormState> _formkey = GlobalKey<FormState>();

  final name = TextEditingController();
  final email = TextEditingController();
  final password = TextEditingController();
  final curr = "";


  
  get controller => AuthViewModel();

  
  
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
                  onSave: (value){},
                  validator: (value){},
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
                    Future.delayed(Duration.zero,() async{
                      _formkey.currentState!.save();
                      if(_formkey.currentState!.validate()){
                        if(email.text != "" && password.text != "") {
                          try{
                          await FirebaseAuth.instance.createUserWithEmailAndPassword(
                            email: email.text,
                            password: password.text
                            ).then((value) async{
                              controller.saveUser(value);
                            },);
                            Get.offAll(ControlView());
                            }catch(e){
                              Get.snackbar(
                                'Error Creating a new account',
                                e.toString(),
                                colorText: Colors.black,
                                snackPosition: SnackPosition.TOP,
                              );
                            }
                        }
                        else{
                          print("Error: \nemail= " + controller.email);
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