import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:karima/model/category_model.Dart';

import '../widgets/custom_button.dart';
import '../widgets/custom_text_form_field.dart';
import '../widgets/widgets.dart';

class EditCategory extends StatefulWidget {
  CategoryModel? model;
  String? id;
  EditCategory({
    this.model,
    this.id,
  });

  @override
  State<EditCategory> createState() => _EditCategoryState();
}

class _EditCategoryState extends State<EditCategory> {
  TextEditingController title = TextEditingController();

  ImagePicker imagePicker = ImagePicker();

  File? _image;

  String? temp;

  Future getImage() async{
    final image = await ImagePicker().pickImage(source: ImageSource.gallery);
    if(image == null) return;

    Reference referenceRoot = FirebaseStorage.instance.ref();
    Reference referenceDirImage = referenceRoot.child('images');
    Reference referenceImageToUpload = referenceDirImage.child(image.name);
    await referenceImageToUpload.putFile(File(image.path));
    String pic = await referenceImageToUpload.getDownloadURL();
    setState(() {
      temp = pic;
    });
    

  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.only(right: 20, left: 20),
          child: Column(
            children: [
              const SizedBox(height: 100,),
              const CustomText(
                alignment: Alignment.center,
                text: "Add Product",
                fontSize: 26,
                color: Colors.black,
              ),
              const SizedBox(height: 50,),
              GestureDetector(
                onTap: () {
                  getImage();
                },
                child: Container(
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
                              offset: Offset(0, 10),
                              )
                          ],
                          shape: BoxShape.rectangle,
                        ),
                        child: temp != null
                        ? Image.network(temp!, fit: BoxFit.fill,)
                        : Image.network(widget.model!.image!),
                      ),
              ),
              const SizedBox(height: 40,),
              CustomTextFormField(
                controller: title,
                text: "Title",
                hint: widget.model!.name!,
                color1: Colors.black,
                color2: Colors.grey,
                onSave: (value){},
                validator: (value){},
              ),
              const SizedBox(height: 40,),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  CustomButton(
                    onPress: (){
                      Get.back();
                    },
                    text: "Cancel",
                    fontsize: 22.0,
                    background: Colors.green,
                  ),
                  CustomButton(
                    onPress: (){
                      final x = {
                        "name": title.text == "" ? widget.model!.name : title.text,
                        "image": temp ?? widget.model!.image,
                      };
                      FirebaseFirestore.instance.collection("Categories").doc(widget.id).update(x);
                      
                    },
                    text: "update",
                    fontsize: 22.0,
                    background: Colors.green,
                  ),
                ],
              ),
              const SizedBox(height: 30,),
            ],
          ),
        ),
      ),
    );
  }
}