import 'dart:io';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:karima/views/widgets/custom_button.dart';
import 'package:karima/views/widgets/custom_text_form_field.dart';
import 'package:karima/views/widgets/widgets.dart';

import '../../model/product_model.dart';

class EditProduct extends StatefulWidget {
  ProductModel? model;
  String? id;

  EditProduct({
    this.model,
    this.id,
  });

  @override
  State<EditProduct> createState() => _EditProductState();
}

class _EditProductState extends State<EditProduct> {
  ImagePicker imagePicker = ImagePicker();

  TextEditingController title = TextEditingController();

  TextEditingController description = TextEditingController();

  TextEditingController brand = TextEditingController();

  TextEditingController category = TextEditingController();

  TextEditingController price = TextEditingController();

  TextEditingController weight = TextEditingController();

  TextEditingController size = TextEditingController();

  String? temp;

  Future getImage() async{
    final image = await ImagePicker().pickImage(source: ImageSource.camera);
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

  final CollectionReference _productCollectionRef = FirebaseFirestore.instance.collection('Products');

  Future<List<QueryDocumentSnapshot>> getProducts() async {
    var value = await _productCollectionRef.get();

    return value.docs;
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
              CustomTextFormField(
                controller: brand,
                text: "Brand",
                hint: widget.model!.brand!,
                color1: Colors.black,
                color2: Colors.grey,
                onSave: (value){},
                validator: (value){},
              ),
              const SizedBox(height: 40,),
              CustomTextFormField(
                controller: description,
                text: "Description",
                hint: widget.model!.description!,
                color1: Colors.black,
                color2: Colors.grey,
                onSave: (value){},
                validator: (value){},
              ),
              const SizedBox(height: 40,),
              CustomTextFormField(
                controller: category,
                text: "Category",
                hint: widget.model!.category!,
                color1: Colors.black,
                color2: Colors.grey,
                onSave: (value){},
                validator: (value){},
              ),
              const SizedBox(height: 40,),
              CustomTextFormField(
                controller: price,
                text: "Price",
                hint: widget.model!.price!,
                color1: Colors.black,
                color2: Colors.grey,
                onSave: (value){},
                validator: (value){},
              ),
              const SizedBox(height: 40,),
              CustomTextFormField(
                controller: size,
                text: "Size",
                hint: widget.model!.size!,
                color1: Colors.black,
                color2: Colors.grey,
                onSave: (value){},
                validator: (value){},
              ),
              const SizedBox(height: 40,),
              CustomTextFormField(
                controller: weight,
                text: "Weight",
                hint: widget.model!.weight!,
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
                        "brand": brand.text == "" ? widget.model!.brand : brand.text,
                        "description": description.text == "" ? widget.model!.description : description.text,
                        "category": category.text == "" ? widget.model!.category : category.text,
                        "price": price.text == "" ? widget.model!.price : price.text,
                        "size": size.text == "" ? widget.model!.size : size.text,
                        "weight": weight.text == "" ? widget.model!.weight : weight.text,
                        "image": temp ?? widget.model!.image,
                      };
                      FirebaseFirestore.instance.collection("Products").doc(widget.id!).update(x);
                      
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