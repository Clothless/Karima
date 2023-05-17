import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';
import 'package:karima/views/widgets/widgets.dart';

class CustomTextFormField extends StatelessWidget {
  final String text;
  final String hint;
  final Color color1;
  final Color color2;
  final Function? onSave;
  final Function? validator;
  final TextEditingController? controller;
  final bool obscureText;
  final bool suggestion;
  final bool autoCorrect;

  CustomTextFormField({
    this.text = "",
    this.hint = "",
    this.color1 = Colors.grey,
    this.color2 = Colors.black,
    this.onSave,
    this.validator,
    this.controller,
    this.obscureText = false,
    this.suggestion = false,
    this.autoCorrect = false,
    });
    
      get value => "";
    

  @override
  Widget build(BuildContext context) {
    return Column(
              children: [
                CustomText(
                  text: text,
                  fontSize: 20,
                  color: color1,
                  ),
                  TextFormField(
                    obscureText: obscureText,
                    enableSuggestions: suggestion,
                    autocorrect: autoCorrect,
                    controller: controller,
                    onSaved: onSave!(value),
                    validator: validator!(value),
                    decoration: InputDecoration(
                      hintText: hint,
                      hintStyle: TextStyle(
                        color: color2
                      )
                    ),
                  ),
              ],
            );
  }
  
  
}