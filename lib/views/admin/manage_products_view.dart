import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';
import 'package:get/get.dart';
import 'package:karima/core/view_model/home_view_model.dart';
import 'package:karima/views/widgets/custom_button.dart';
import 'package:karima/views/widgets/widgets.dart';

import 'add_product_view.dart';
import 'edit_product.dart';

class ManageProductsView extends StatefulWidget {
  ManageProductsView({super.key});

  @override
  State<ManageProductsView> createState() => _ManageProductsViewState();
}


class _ManageProductsViewState extends State<ManageProductsView> {  
  final CollectionReference _productCollectionRef = FirebaseFirestore.instance.collection('Products');
  Future<List<QueryDocumentSnapshot>> getProducts() async {
    var value = await _productCollectionRef.get();

    return value.docs;
  }


  @override
  Widget build(BuildContext context) {
    return GetBuilder<HomeViewModel>(
      init: HomeViewModel(),
      builder: (controller) => controller.loading.value
      ? const Center(child: CircularProgressIndicator())
      : Scaffold(
          body: Container(
            padding: const EdgeInsets.only(top: 80, right: 20, left: 20),
            child: Column(
              children: [
                Center(
                  child: CustomButton(
                    text: "Add new product",
                    background: Colors.green,
                    fontsize: 18,
                    onPress: (){
                      Get.to(AddProductView());
                    },
                  ),
                ),
                const SizedBox(height: 20,),
                Expanded(
                  child: ListView.separated(
                      itemBuilder: (context, index){
                        return Column(
                          children: [
                            SizedBox(
                                height: 140,
                                child: Row(
                                  children: [
                                    Padding(
                                      padding: const EdgeInsets.only(left: 0),
                                      child: Row(
                                        children: [
                                          SizedBox(
                                            width: 140,
                                            child: Image.network(controller.productModel[index].image!,),
                                            ),
                                          Column(
                                            crossAxisAlignment: CrossAxisAlignment.start,
                                            mainAxisAlignment: MainAxisAlignment.start,
                                            children: [
                                              CustomText(
                                                text: controller.productModel[index].name!,
                                                height: 16.0,
                                                width: MediaQuery.of(context).size.width * 0.5,
                                                ),
                                              const SizedBox(height: 10,),
                                              CustomText(
                                                text: '\$ ${controller.productModel[index].price!}',
                                                color: Colors.green,
                                                ),
                                              const SizedBox(height: 10),
                                              Row(
                                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                                children: [
                                                  CustomButton(
                                                    text: "Edit",
                                                    background: Colors.green,
                                                    foreground: Colors.white,
                                                    fontsize: 14,
                                                    onPress: (){
                                                      getProducts().then((value) {
                                                        Get.to(EditProduct(model: controller.productModel[index], id: value[index].id,));
                                                      });
                                                      
                                                    },
                                                  ),
                                                  CustomButton(
                                                    text: "Delete",
                                                    background: Colors.red.shade400,
                                                    foreground: Colors.white,
                                                    fontsize: 14,
                                                    onPress: (){
                                                      showDialog(
                                                        context: context,
                                                        builder: (BuildContext context) {
                                                          return AlertDialog(
                                                            actionsAlignment: MainAxisAlignment.spaceBetween,
                                                            title: const Text('Delete!'),
                                                            content: const Text('Do you really want to Delete it?'),
                                                              actions: [
                                                                Row(
                                                                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                                                                  children: [
                                                                    CustomButton(       
                                                                      onPress: () {
                                                                        Get.back();
                                                                      },
                                                                      pad: 0.0,
                                                                      text: 'Cancel',
                                                                      fontsize: 12,
                                                                    ),
                                                                    CustomButton(       
                                                                      onPress: () {
                                                                        getProducts().then((value) {
                                                                          FirebaseFirestore.instance.collection("Products").doc(value[index].id).delete();
                                                                        });
                                                                        controller.productModel.removeAt(index);
                                                                        setState(() {
                                                                          Get.back();
                                                                        });
                                                                      },
                                                                      pad: 0.0,
                                                                      text: 'Continue',
                                                                      fontsize: 12,
                                                                    ),
                                                                  ],
                                                                ),
                                                            ],
                                                          );
                                                        }
                                                      );
                                                    },
                                                  ),
                                                ],
                                              ),
                                              
                                            ],
                                          ),
                                          
                                        ],
                                      ),
                                    ),
                                  ],
                                ),
                            ),
                            const SizedBox(height: 20,)
                          ],
                        );
                      },
                      itemCount: controller.productModel.length, separatorBuilder: (BuildContext context, int index) {
                        return const SizedBox(height: 0,);
                      },
                      ),
                  ),
              ],
            ),
          ),
        ),
      
    );
  }
}