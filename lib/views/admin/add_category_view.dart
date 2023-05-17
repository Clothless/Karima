import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:karima/model/category_model.Dart';
import 'package:karima/views/widgets/custom_button.dart';
import 'package:karima/views/widgets/custom_text_form_field.dart';
import 'package:karima/views/widgets/widgets.dart';

class AddCategory extends StatefulWidget {
  const AddCategory({super.key});

  @override
  State<AddCategory> createState() => _AddCategoryState();
}

class _AddCategoryState extends State<AddCategory> {
  ImagePicker imagePicker = ImagePicker();
  
  TextEditingController title = TextEditingController();

  File? _image;
  String? temp;

  final CollectionReference _categoryCollectionRef = FirebaseFirestore.instance.collection('Categories');

  Future<DocumentSnapshot> getCurrentProduct (String uid) async{
    return await _categoryCollectionRef.doc(uid).get();
  }


  Future getImage() async{
    final image = await ImagePicker().pickImage(source: ImageSource.gallery);
    if(image == null) return;

    final imageTemp = File(image.path);
    Reference referenceRoot = FirebaseStorage.instance.ref();
    Reference referenceDirImage = referenceRoot.child('images');
    Reference referenceImageToUpload = referenceDirImage.child(image.name);
    await referenceImageToUpload.putFile(File(image.path));
    String pic = await referenceImageToUpload.getDownloadURL();
    temp = pic;
    setState(() {
      _image = imageTemp;
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
                text: "Add Category",
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
                        child: _image != null
                        ? Image.file(_image!, fit: BoxFit.fill,)
                        : Image.asset("assets/images/pro1.png",),
                      ),
              ),
              const SizedBox(height: 40,),
              CustomTextFormField(
                controller: title,
                text: "Name",
                hint: "Category name",
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
                      CategoryModel x = CategoryModel(
                        name: title.text,
                        image: temp,
                      );
                      _categoryCollectionRef.add(x.toJson());
                      Get.back();
                    },
                    text: "Add",
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