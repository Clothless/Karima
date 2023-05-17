import 'dart:io';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:karima/model/product_model.dart';
import 'package:karima/views/admin/manage_products_view.dart';
import 'package:karima/views/widgets/custom_button.dart';
import 'package:karima/views/widgets/custom_text_form_field.dart';
import 'package:karima/views/widgets/widgets.dart';

class AddProductView extends StatefulWidget {
  
  @override
  State<AddProductView> createState() => _AddProductViewState();
}

class _AddProductViewState extends State<AddProductView> {
  ImagePicker imagePicker = ImagePicker();

  TextEditingController title = TextEditingController();
  TextEditingController description= TextEditingController();
  TextEditingController brand = TextEditingController();
  TextEditingController category = TextEditingController();
  TextEditingController price = TextEditingController();
  TextEditingController weight = TextEditingController();
  TextEditingController size = TextEditingController();

  File? _image;
  String? temp;

  final CollectionReference _productCollectionRef = FirebaseFirestore.instance.collection('Products');
  Future<void> addProductToFirestore(ProductModel productModel) async{
    return await _productCollectionRef.doc(productModel.productID).set(productModel.tojson());
  }

  Future<DocumentSnapshot> getCurrentProduct (String uid) async{
    return await _productCollectionRef.doc(uid).get();
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
                        child: _image != null
                        ? Image.file(_image!, fit: BoxFit.fill,)
                        : Image.asset("assets/images/pro1.png",),
                      ),
              ),
              const SizedBox(height: 40,),
              CustomTextFormField(
                controller: title,
                text: "Title",
                hint: "Product name",
                color1: Colors.black,
                color2: Colors.grey,
                onSave: (value){},
                validator: (value){},
              ),
              const SizedBox(height: 40,),
              CustomTextFormField(
                controller: brand,
                text: "Brand",
                hint: "Product brand",
                color1: Colors.black,
                color2: Colors.grey,
                onSave: (value){},
                validator: (value){},
              ),
              const SizedBox(height: 40,),
              CustomTextFormField(
                controller: description,
                text: "Description",
                hint: "Product description",
                color1: Colors.black,
                color2: Colors.grey,
                onSave: (value){},
                validator: (value){},
              ),
              const SizedBox(height: 40,),
              CustomTextFormField(
                controller: category,
                text: "Category",
                hint: "Product category",
                color1: Colors.black,
                color2: Colors.grey,
                onSave: (value){},
                validator: (value){},
              ),
              const SizedBox(height: 40,),
              CustomTextFormField(
                controller: price,
                text: "Price",
                hint: "Product price",
                color1: Colors.black,
                color2: Colors.grey,
                onSave: (value){},
                validator: (value){},
              ),
              const SizedBox(height: 40,),
              CustomTextFormField(
                controller: size,
                text: "Size",
                hint: "Product size",
                color1: Colors.black,
                color2: Colors.grey,
                onSave: (value){},
                validator: (value){},
              ),
              const SizedBox(height: 40,),
              CustomTextFormField(
                controller: weight,
                text: "Weight",
                hint: "Product weight",
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
                      ProductModel pro = ProductModel(
                        image: temp,
                        name: title.text,
                        brand: brand.text,
                        description: description.text,
                        category: category.text,
                        price: price.text,
                        size: size.text,
                        weight: weight.text,
                      );
                      addProductToFirestore(pro);
                      
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